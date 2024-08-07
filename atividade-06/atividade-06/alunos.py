from fastapi import FastAPI, HTTPException
import sqlite3

app = FastAPI()

def idin(id):
    conn = sqlite3.connect('dbalunos.db')
    cursor = conn.cursor()
    cursor.execute('SELECT id FROM TB_ALUNO')
    ids = cursor.fetchall()
    conn.close()
    return (id,) in ids

@app.post("/criar_aluno/")
def criar_aluno(aluno_nome: str,  endereco: str = None, id: int = None):
    if not idin(id):
        conn = sqlite3.connect('dbalunos.db')
        cursor = conn.cursor()
        cursor.execute('''
        INSERT INTO TB_ALUNO (id, aluno_nome, endereco) VALUES (?, ?, ?)
        ''', (id, aluno_nome, endereco))
        conn.commit()
        conn.close()
        return {"id": cursor.lastrowid, "aluno_nome": aluno_nome, "endereco": endereco}
    else:
        raise HTTPException(status_code=409, detail="Já existe um aluno com este id")

@app.get("/listar_alunos/")
def listar_alunos():
    conn = sqlite3.connect('dbalunos.db')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM TB_ALUNO')
    alunos = cursor.fetchall()
    conn.close()
    return [{"id": id, "aluno_nome": nome, "endereco": endereco} for id, nome, endereco in alunos]

@app.get("/listar_um_aluno/{id}")
def listar_um_aluno(id: int):
    conn = sqlite3.connect('dbalunos.db')
    cursor = conn.cursor()
    cursor.execute('SELECT aluno_nome, endereco FROM TB_ALUNO WHERE id = ?', (id,))
    aluno = cursor.fetchone()
    conn.close()
    if aluno:
        return {"id": id, "aluno_nome": aluno[0], "endereco": aluno[1]}
    else:
        raise HTTPException(status_code=404, detail="Aluno não encontrado")

@app.put("/atualizar_aluno/{id}")
def atualizar_aluno(id: int, novo_id: int = None, aluno_nome: str = None,  endereco: str = None):
    if novo_id == None or not idin(novo_id):
        conn = sqlite3.connect('dbalunos.db')
        cursor = conn.cursor()
        cursor.execute('''
        UPDATE TB_ALUNO SET id = ?, aluno_nome = ?, endereco = ? WHERE id = ?
        ''', (novo_id, aluno_nome, endereco, id))
        conn.commit()
        conn.close()
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Aluno não encontrado")
        return {"id": novo_id, "aluno_nome": aluno_nome, "endereco": endereco}
    else:
        raise HTTPException(status_code=409, detail="Já existe um aluno com este id")

@app.delete("/excluir_aluno/{id}")
def excluir_aluno(id: int):
    conn = sqlite3.connect('dbalunos.db')
    cursor = conn.cursor()
    cursor.execute('DELETE FROM TB_ALUNO WHERE id = ?', (id,))
    conn.commit()
    conn.close()
    if cursor.rowcount == 0:
        raise HTTPException(status_code=404, detail="Aluno não encontrado")
    return {"detail": "Aluno excluído com sucesso"}
