# Pruebas-automatizadas-
Proyecto de Gestion de Calidad de la UCB
# Pruebas Automatizadas - Demoblaze

## Descripción
Proyecto de pruebas automatizadas para la aplicación web Demoblaze usando Cucumber, Capybara y Ruby.

## Requisitos Previos
- Ruby 2.7+
- Bundler
- Chrome
- ChromeDriver

## Instalación

1. Clonar el repositorio
2. Ejecutar `bundle install`
3. Crear archivo `.env` con:

```
DEMOBLAZE_USER=usuario_prueba
DEMOBLAZE_PASSWORD=contraseña
BASE_URL=https://www.demoblaze.com
```


## Ejecución de Pruebas

```bash
# Todas las pruebas
cucumber

# Pruebas por tag
cucumber -t @smoke

# Feature específico
cucumber features/demoblaze_about_us.feature
```

DEMOBLAZE
```bash
# Generar reporte HTML
cucumber --format html --out report.html

# Generar reporte JSON
cucumber --format json --out report.json
```
# Reporte HTML
cucumber --format html --out reports/report.html

# Reporte JSON
cucumber --format json --out reports/report.json

# Smoke Test con reporte
cucumber -t @smoke --format html --out reports/smoke_report.html

Resultados
Tipo	    Escenarios	Steps	Tiempo	Estado
Smoke Test	  16	     105	3m 17s	 100%
Full Regression	50	     293	10m 23s	 100%

ESTRUCTURA DEL PROYECTO
features/
├── step_definitions/     # Implementación de los pasos
├── support/              # Configuración y hooks
└── *.feature            # Escenarios de prueba

AUTOR: Ariel
FECHA: Junio 2026

