const express = require('express');
const { Pool } = require('pg');
const promClient = require('prom-client');

const app = express();
const PORT = 3000;

// PostgreSQL
const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD || 'admin',
  database: process.env.DB_NAME || 'vendas',
  port: 5432
});

// Prometheus Registry
const register = new promClient.Registry();
promClient.collectDefaultMetrics({ register });

// Métricas customizadas
const httpRequestsTotal = new promClient.Counter({
  name: 'http_requests_total',
  help: 'Total de requisições HTTP',
  labelNames: ['method', 'route', 'status'],
  registers: [register]
});

const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duração das requisições',
  labelNames: ['method', 'route'],
  registers: [register]
});

// Middleware de métricas
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = (Date.now() - start) / 1000;
    httpRequestsTotal.inc({ method: req.method, route: req.path, status: res.statusCode });
    httpRequestDuration.observe({ method: req.method, route: req.path }, duration);
  });
  next();
});

// Rota /metrics
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

// Rotas de dados
app.get('/produtos', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM produtos ORDER BY nome');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/vendas', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT v.*, p.nome as produto_nome 
      FROM vendas v 
      JOIN produtos p ON v.produto_id = p.id 
      ORDER BY v.data_venda DESC 
      LIMIT 20
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/vendas-por-categoria', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT p.categoria, 
             COUNT(v.id) as total_vendas,
             SUM(v.valor_total) as receita_total
      FROM vendas v
      JOIN produtos p ON v.produto_id = p.id
      GROUP BY p.categoria
      ORDER BY receita_total DESC
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/top-produtos', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT p.nome, 
             p.categoria,
             SUM(v.quantidade) as qtd_vendida,
             SUM(v.valor_total) as receita
      FROM vendas v
      JOIN produtos p ON v.produto_id = p.id
      GROUP BY p.id, p.nome, p.categoria
      ORDER BY receita DESC
      LIMIT 10
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`API rodando na porta ${PORT}`);
  console.log(`Métricas: http://localhost:${PORT}/metrics`);
});