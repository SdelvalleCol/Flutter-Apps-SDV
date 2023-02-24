const express = require('express');
const app = express();
const pool = require('./db');
const token = require('jsonwebtoken')
const env = require('dotenv')

app.listen(3000, () => {
    env.config(

    )
    console.log("Server ONLIVE");
});

app.post('/api/post/:corre/:contrasena', (req, res) => {
    var corre = req.params.corre
    var contra = req.params.contrasena
    pool.query(`SELECT * FROM personas WHERE correo = '${corre}' AND contrasena = '${contra}' `, async (erro, result) => {
        if (erro) {
            console.log(erro)
            res.status(204).end()
        } else {
            if (result.length == 0) {
                console.log("No hay")
                res.send("no")
            } else if (result.length == 1) {
                console.log("Encontrado")
                var correo = result[0]["correo"]
                var contra = result[0]["contrasena"]
                const tk = token.sign({
                    correo,
                    contra,
                }, process.env.contrasena)
                res.send(tk)
            }
            res.status(200).end()
        }
    })
})

app.post('/api/post/verify/thens/:token', (req, res) => {
    var tok = req.params
    var data = token.decode(tok["token"])
    pool.query(`SELECT * FROM personas where correo = '${data["correo"]}' and contrasena = '${data["contra"]}'`, async (err, result) => {
        try {
            if(res.status==500){
                res.send(null)
            }
            else if (result.length > 0) {
                res.send(data["correo"])
            }
        } catch (e) {
            res.send(null)
        }

        res.status(200).end()
    })
})
