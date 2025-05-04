@echo off
echo Compilando projeto...

REM Verifica se a variável TOMCAT_HOME está definida
IF "%TOMCAT_HOME%" == "" (
    echo ATENÇÃO: A variável TOMCAT_HOME não está definida!
    echo Por favor, insira o caminho para o diretório do Tomcat:
    set /p TOMCAT_HOME=
)

REM Compila as classes Java
IF NOT EXIST "build\classes" mkdir build\classes
javac -d build\classes -cp "%TOMCAT_HOME%\lib\*" src\main\java\**\*.java

REM Cria a estrutura do WAR
IF NOT EXIST "build\war\WEB-INF\classes" mkdir build\war\WEB-INF\classes
xcopy /E /Y src\main\webapp\* build\war\
xcopy /E /Y build\classes\* build\war\WEB-INF\classes\

REM Constrói o arquivo WAR
IF NOT EXIST "build\war\WEB-INF\lib" mkdir build\war\WEB-INF\lib
echo Copiando dependências para WEB-INF\lib...
REM Adicione os JARs necessários aqui
copy "lib\jakarta.servlet.jsp.jstl-3.0.0.jar" "build\war\WEB-INF\lib\"
copy "lib\jakarta.servlet.jsp.jstl-api-3.0.0.jar" "build\war\WEB-INF\lib\"

REM Empacotar WAR
jar -cf biblioteca.war -C build\war .

echo WAR criado com sucesso: biblioteca.war
echo.
echo Para implantar, copie biblioteca.war para a pasta %TOMCAT_HOME%\webapps e reinicie o Tomcat. 