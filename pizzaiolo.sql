-- Cria a tabela de pizzaiolos
CREATE TABLE Pizzaiolos (
    PizzaioloID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Especialidade VARCHAR(255)
);

-- Cria a tabela de ingredientes
CREATE TABLE Ingredientes (
    IngredienteID INT PRIMARY KEY,
    Nome VARCHAR(255)
);

-- Cria a tabela de pizzas
CREATE TABLE Pizzas (
    PizzaID INT PRIMARY KEY,
    Nome VARCHAR(255),
    PizzaioloID INT,
    Instrucoes TEXT,
    FOREIGN KEY (PizzaioloID) REFERENCES Pizzaiolos(PizzaioloID)
);

-- Cria a tabela de relação entre pizzas e ingredientes
CREATE TABLE PizzaIngredientes (
    PizzaID INT,
    IngredienteID INT,
    PRIMARY KEY (PizzaID, IngredienteID),
    FOREIGN KEY (PizzaID) REFERENCES Pizzas(PizzaID),
    FOREIGN KEY (IngredienteID) REFERENCES Ingredientes(IngredienteID)
);

-- Insere dados nas tabelas
INSERT INTO Pizzaiolos (PizzaioloID, Nome, Especialidade)
VALUES
    (1, 'Ricardo', 'Toscana'),
    (2, 'Fatima', 'Mussarela');

INSERT INTO Ingredientes (IngredienteID, Nome)
VALUES
    (1, 'Molho de Tomate'),
    (2, 'Oregano'),
    (3, 'Queijo'),
    (4, 'Toscana');

INSERT INTO Pizzas (PizzaID, Nome, PizzaioloID, Instrucoes)
VALUES
    (101, 'Toscana', 1, 'Instruções para fazer Toscana'),
    (102, 'Mussarela', 2, 'Instruções para fazer Mussarela');

INSERT INTO PizzaIngredientes (PizzaID, IngredienteID)
VALUES
    (101, 1),
    (101, 2),
    (101, 4),
    (102, 1),
    (102, 2),
    (102, 3);

-- Crie um relatório com todas as pizzas e os pizzaiolos aptos a produzi-las
SELECT Pizzas.Nome AS Pizza, Pizzaiolos.Nome AS Pizzaiolo
FROM Pizzas
JOIN Pizzaiolos ON Pizzas.PizzaioloID = Pizzaiolos.PizzaioloID;

-- Crie um relatório com todas as pizzas e seus ingredientes
SELECT Pizzas.Nome AS Pizza, GROUP_CONCAT(Ingredientes.Nome SEPARATOR ', ') AS Ingredientes
FROM Pizzas
JOIN PizzaIngredientes ON Pizzas.PizzaID = PizzaIngredientes.PizzaID
JOIN Ingredientes ON PizzaIngredientes.IngredienteID = Ingredientes.IngredienteID
GROUP BY Pizzas.Nome;

-- Crie um relatório com todos os ingredientes e as pizzas onde são utilizados
SELECT Ingredientes.Nome AS Ingrediente, GROUP_CONCAT(Pizzas.Nome SEPARATOR ', ') AS Pizzas
FROM Ingredientes
JOIN PizzaIngredientes ON Ingredientes.IngredienteID = PizzaIngredientes.IngredienteID
JOIN Pizzas ON PizzaIngredientes.PizzaID = Pizzas.PizzaID
GROUP BY Ingredientes.Nome;

-- Crie um relatório com os sabores de todas as pizzas, o nome dos pizzaiolos que as fazem e as instruções para produzi-las
SELECT Pizzas.Nome AS Pizza, Pizzaiolos.Nome AS Pizzaiolo, Pizzas.Instrucoes AS Instrucoes
FROM Pizzas
JOIN Pizzaiolos ON Pizzas.PizzaioloID = Pizzaiolos.PizzaioloID;