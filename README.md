# Dashboard de Vendas com Observabilidade

Sistema de monitoramento de vendas usando PostgreSQL, Prometheus e Grafana.

## 🚀 Iniciar
```bash
docker-compose up -d
```

Aguarde 30 segundos.

## 🔧 Configurar Grafana

1. Acesse http://localhost:3001 (login: admin/admin)

### PostgreSQL:
- Host: `postgres:5433`
- Database: `vendas`
- User/Password: `admin`/`admin`
- TLS: disable

### Prometheus:
- URL: `http://prometheus:9090`

### Importar Dashboard:
- Dashboards → Import → Cole o conteúdo de `dashboard.json`

## 📊 Endpoints

- API: http://localhost:3000
- Métricas: http://localhost:3000/metrics
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3001

## 🧪 Gerar Tráfego
```powershell
for ($i=1; $i -le 30; $i++) { 
  Invoke-WebRequest -Uri http://localhost:3000/produtos
  Start-Sleep -Milliseconds 500
}
```

## 📊 Dashboard

O dashboard inclui:
- Total de produtos, vendas e receita
- Vendas por categoria
- Taxa de requisições
- Latência p95
- Uso de memória

## 🛑 Parar
```bash
docker-compose down
```
