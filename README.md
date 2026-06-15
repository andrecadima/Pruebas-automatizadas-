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

ESTRUCTURA DEL PROYECTO
features/
├── step_definitions/     # Implementación de los pasos
├── support/              # Configuración y hooks
└── *.feature            # Escenarios de prueba

AUTOR: Ariel
FECHA: Junio 2026

