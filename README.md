# Biblioteca

Um sistema de gerenciamento para bibliotecas.

## Descrição
Este projeto tem como objetivo criar um sistema de gerenciamento de bibliotecas que permite catalogar, emprestar e gerenciar livros e outros recursos.

## Funcionalidades (Planejadas)
- Cadastro de livros
- Controle de empréstimos
- Gerenciamento de usuários
- Pesquisa no acervo
- Relatórios estatísticos

## Tecnologias
- Em definição

## 📋 Sobre o Projeto

Este sistema foi desenvolvido para facilitar a administração de bibliotecas comunitárias, promovendo o acesso à leitura e cultura em comunidades. A aplicação permite:

- Cadastro e gerenciamento de livros
- Cadastro e gerenciamento de usuários
- Consulta ao acervo
- Controle de empréstimos e devoluções

## 🚀 Tecnologias Utilizadas

- **Linguagem:** Java (JDK 11)
- **Frontend:** JSP, JSTL, Bootstrap 5
- **Backend:** Servlets, JDBC
- **Banco de Dados:** MySQL
- **Build:** Maven
- **Servidor:** Apache Tomcat

## 🏗️ Estrutura do Projeto

O projeto segue o padrão MVC (Model-View-Controller):

```
/src/main
  /java
    /controller   - Servlets que processam as requisições
    /dao          - Classes de acesso ao banco de dados
    /model        - Classes de modelo (beans)
    /service      - Camada de serviços
    /util         - Classes utilitárias
  /webapp
    /WEB-INF
      /views      - Páginas JSP
      web.xml     - Configuração do servlet
    /assets       - Recursos estáticos (CSS, JS, imagens)
    index.jsp     - Página inicial
```

## 🛠️ Instalação e Configuração

### Pré-requisitos
- JDK 11 ou superior
- Maven
- MySQL
- Apache Tomcat 9

### Configuração do Banco de Dados

1. Crie o banco de dados:
```sql
CREATE DATABASE IF NOT EXISTS db_mobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. Execute o script SQL de inicialização:
```bash
mysql -u seu_usuario -p db_mobile < init-db.sql
```

### Configuração do Projeto

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/sistema-de-biblioteca-comunitaria.git
cd sistema-de-biblioteca-comunitaria
```

2. Configure a conexão com o banco de dados:
   Edite o arquivo `src/main/java/util/DatabaseConnection.java` e ajuste as informações de conexão (URL, usuário e senha).

3. Construa o projeto:
```bash
mvn clean package
```

4. Deploy no Tomcat:
   - Copie o arquivo WAR gerado (`target/sistema-de-biblioteca-comunitaria.war`) para o diretório `webapps` do Tomcat
   - Ou use o plugin do Tomcat para executar diretamente:
   ```bash
   mvn tomcat7:run
   ```

5. Acesse a aplicação em `http://localhost:8080/sistema-de-biblioteca-comunitaria`

## 📱 Funcionalidades Principais

### Autenticação de Usuários
- Login com email e senha
- Sistema de sessões para manter usuários autenticados
- Controle de acesso baseado em perfil de usuário

### Gerenciamento de Livros
- Formulário para cadastro de novos livros
- Listagem com paginação
- Edição e exclusão de registros
- Controle de exemplares disponíveis

### Gerenciamento de Usuários
- Formulário para cadastro de novos membros
- Listagem com filtros
- Edição de dados cadastrais
- Ativação/desativação de contas

### Pesquisa no Acervo
- Busca por título, autor e gênero
- Filtros avançados
- Exibição da disponibilidade dos exemplares

## 🧪 Testes

Para executar os testes automatizados:
```bash
mvn test
```

## 🤝 Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Faça commit das suas alterações (`git commit -m 'Add some AmazingFeature'`)
4. Envie para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📞 Contato

Para dúvidas ou sugestões, entre em contato através de [felixskmarcio2@gmail.com].

## 📄 Licença

Este projeto está licenciado sob a licença MIT. 