🧵 Stitch - Medtronic Suture Library


Stitch é uma ferramenta de consulta técnica desenvolvida para facilitar o dia a dia de representantes e consultores cirúrgicos. O aplicativo permite a busca instantânea de suturas Medtronic, oferecendo correspondências por códigos de produtos, nomes de concorrentes e compostos químicos.


🚀 Funcionalidades


Busca Inteligente Multi-Campo: Encontre produtos digitando códigos Medtronic, referências de concorrentes (JJ), nomes comerciais (ex: Vicryl, Monocryl) ou o composto do fio.

Destaque em Tempo Real (Highlighting): Visualização clara do termo buscado diretamente nos resultados.

Interface Adaptativa: Exibição dinâmica de informações secundárias apenas quando relevantes à busca.

Ficha Técnica Completa: Navegação detalhada com informações de RMS, especificações de agulha e descrições para licitação.

Operação 100% Offline: Banco de dados local em JSON para consultas rápidas em ambientes hospitalares sem conexão.


🛠️ Arquitetura Técnica


O projeto segue os princípios de separação de responsabilidades (Clean Code) e o padrão Master-Detail:

Linguagem: Swift 6

Framework: SwiftUI

Processamento de Dados: Python (Scripts de automação ETL)

Banco de Dados: JSON local (convertido de CSV estruturado)


📂 Estrutura do Projeto


ContentView.swift: Gerenciamento da lógica de busca e interface principal.

SuturaDetailView.swift: Exibição organizada das especificações técnicas.

Sutura.swift: Modelo de dados (Struct) compatível com Codable.

converter.py: Script Python para higienização de dados e conversão de CSV para JSON.


⚙️ Como Atualizar o Banco de Dados


Sempre que houver novos produtos ou alterações na tabela:

Atualize o arquivo Tabela suturas.csv.

Execute o script de conversão:

Bash
python converter.py
O script irá limpar valores nulos (NaN), aplicar regras de automação de família e gerar um novo suturas.json.

Recompile o projeto no Xcode para carregar a nova "Fonte da Verdade".


📝 Notas de Versão


v1.0: Lançamento inicial com busca por concorrente e composto.

v1.1: Adição de Highlighting e Interface Contextual.
