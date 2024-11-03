# Consulta de salário médio em USD por ano de trabalho e nível de experiencia.
SELECT 
    ano_de_trabalho,
    nivel_de_experiencia,
    CONCAT('U$ ', FORMAT(AVG(salario_em_usd), 2)) AS media_salarial,
    COUNT(*) AS total_funcionarios
FROM 
    dataset_salary
WHERE 
    salario_em_usd IS NOT NULL
GROUP BY 
    ano_de_trabalho, 
    nivel_de_experiencia
ORDER BY 
    ano_de_trabalho,
    AVG(salario_em_usd) ASC;

# calculo do salário médio em USD para cada combinação de cargo e residencia_do_funcionario
SELECT 
    cargo,
    residencia_do_funcionario,
    CONCAT('U$ ', FORMAT(AVG(salario_em_usd), 2)) AS media_salarial,
    COUNT(*) AS total_funcionarios
FROM 
    dataset_salary
WHERE 
    salario_em_usd IS NOT NULL
GROUP BY 
    cargo, residencia_do_funcionario
ORDER BY 
    cargo;
    
# Calculo da média da proporcao_remota agrupada por cargo
SELECT 
    cargo,
    FORMAT(AVG(proporcao_remota), 2) AS media_proporcao_remota,
    COUNT(*) AS total_vagas
FROM
    dataset_salary
GROUP BY
    cargo
ORDER BY
    AVG(proporcao_remota)desc;
    
# consulta dos 10 paises com mais empresas por ano

WITH CountryCounts AS (
    SELECT 
        ano_de_trabalho,
        localizacao_da_empresa,
        COUNT(*) AS empresa_contagem
    FROM 
        dataset_salary
    GROUP BY 
        ano_de_trabalho, localizacao_da_empresa
),
RankedCountries AS (
    SELECT 
        ano_de_trabalho,
        localizacao_da_empresa,
        empresa_contagem,
        ROW_NUMBER() OVER(PARTITION BY ano_de_trabalho ORDER BY empresa_contagem DESC) AS ranking
    FROM 
        CountryCounts
)
SELECT 
    ano_de_trabalho,
    localizacao_da_empresa,
    empresa_contagem,
    ranking
FROM 
    RankedCountries
WHERE 
    ranking <= 10
ORDER BY 
    ano_de_trabalho, ranking;
    
    
    