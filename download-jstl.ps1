# Script para baixar as bibliotecas JSTL para Jakarta EE 10
$api_url = "https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.0/jakarta.servlet.jsp.jstl-api-3.0.0.jar"
$impl_url = "https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/3.0.0/jakarta.servlet.jsp.jstl-3.0.0.jar"

# Criar diretório lib se não existir
if (-not (Test-Path -Path "lib")) {
    New-Item -ItemType Directory -Path "lib"
}

# Baixar arquivos
Write-Host "Baixando arquivos JSTL..."
Invoke-WebRequest -Uri $api_url -OutFile "lib\jakarta.servlet.jsp.jstl-api-3.0.0.jar"
Invoke-WebRequest -Uri $impl_url -OutFile "lib\jakarta.servlet.jsp.jstl-3.0.0.jar"

Write-Host "Download concluído! Arquivos salvos no diretório lib:"
Get-ChildItem -Path "lib" 