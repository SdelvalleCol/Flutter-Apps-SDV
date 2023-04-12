const express = require('express');
const app = express();
const pool = require('./db');
const token = require('jsonwebtoken')
const env = require('dotenv')

app.listen(3000, () => {
    env.config()
    console.log("Server ONLIVE");
});

//Generar inicio sesion
app.post('/api/post/ingreso/:corre/:contrasena', (req, res) => {
    var corre = req.params.corre
    var contra = req.params.contrasena
    pool.query(`SELECT * FROM user WHERE correo = '${corre}' AND password = '${contra}' `, async (erro, result) => {
        if (erro) {
            console.log(erro)
            res.status(204).end()
        } else {
            if (result.length == 0) {
                console.log("No hay")
                res.status(204).end()
            } else if (result.length == 1) {
                console.log("Encontrado")
                var correo = result[0]["correo"]
                var contra = result[0]["password"]
                const tk = token.sign({
                    correo,
                    contra,
                }, process.env.contrasena)
                res.send(tk)
            }
        }
    })
})

//Generar token
app.post('/api/post/:corre/:contrasena', (req, res) => {
    var corre = req.params.corre
    var contra = req.params.contrasena
    pool.query(`SELECT * FROM user WHERE correo = '${corre}' AND password = '${contra}' `, async (erro, result) => {
        if (erro) {
            console.log(erro)
            res.status(204).end()
        } else {
            if (result.length == 0) {
                console.log("No hay")
                res.status(204).end()
            } else if (result.length == 1) {
                console.log("Encontrado")
                var correo = result[0]["correo"]
                var contra = result[0]["password"]
                const tk = token.sign({
                    correo,
                    contra,
                }, process.env.contrasena)
                res.send(tk)
                pool.query(`UPDATE user
                SET token = '${tk}'
                WHERE correo = '${corre}' and password = '${contra}'`)
                res.status(200).end()
            }

        }
    })
})

//Desactivar huella
app.post('/api/des/token/:token', (req, res) => {
    try {
        var tok = req.params.token
        var data = token.decode(tok)
        pool.query(`SELECT token FROM user where correo = '${data["correo"]}' and password = '${data["contra"]}'`, (err, resu) => {
            if (resu.length == 1 && resu[0]["token"] != null) {
                var tokeninterno = resu[0]["token"]
                var datainterna = token.decode(tokeninterno)
                if (datainterna["correo"] == data["correo"]) {
                    pool.query(`UPDATE user
                        SET token = NULL
                        WHERE correo = '${data["correo"]}'`)
                    res.status(200).end()
                } else {
                    res.status(205).end()
                }
            } else {
                res.status(204).end()
            }
        })
    } catch (e) {
        console.log(e)
        res.status(204).end()
    }
})

//Verificar con huella
app.post('/api/verify/user/:token', (req, res) => {
    try {
        var tok = req.params.token
        var data = token.decode(tok)
        pool.query(`SELECT * FROM user where correo = '${data["correo"]}' and password = '${data["contra"]}'`, (err, resu) => {
            if (resu.length == 1 && resu[0]["token"] != null) {
                var tokeninterno = resu[0]["token"]
                var datainterna = token.decode(tokeninterno)
                if (datainterna["correo"] == data["correo"]) {
                    res.send(data["correo"])
                    res.status(200).end()
                }
                res.status(204).end()
            } else {
                res.status(204).end()
            }
        })
    } catch (e) {
        console.log(e)
        res.status(204).end()
    }
})
