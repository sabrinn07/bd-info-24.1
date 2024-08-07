import sqlite3

if __name__ == "__main__":
    conn = sqlite3.connect("dbalunos.db")

    cursor = conn.cursor()
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        aluno_nome varchar(50),
        endereco varchar(100)
    )
    ''')

    conn.commit()
    conn.close()