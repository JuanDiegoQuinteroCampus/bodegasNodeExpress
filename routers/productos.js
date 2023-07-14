import mysql from "mysql2";
import { Router } from "express";
const storageProductos = Router();

let con = undefined;

storageProductos.use((req, res, next) => {
  let myConfig = JSON.parse(process.env.MY_CONNECT);
  con = mysql.createPool(myConfig);
  next();
});

storageProductos.get("/", (req, res) => {
  con.query(
    `SELECT p.id, p.nombre, SUM(i.cantidad) AS Total
      FROM productos p
      INNER JOIN inventarios i ON p.id = i.id
      GROUP BY p.id, p.nombre
      ORDER BY Total DESC`,
    (err, data, fil) => {
      if (err) {
        console.error(err);
        res.status(500).send("Error en el servidor");
      } else {
        res.send(JSON.stringify(data));
      }
    }
  );
});
storageProductos.post("/", (req, res) => {
    const {
      nombre,
      cantidadInicial
    } = req.body;
  
    const insertProductoQuery = `INSERT INTO productos (nombre) VALUES (?)`;
  
    con.query(insertProductoQuery, [nombre], (err, result) => {
      if (err) {
        console.error("Error al insertar el producto:", err);
        return res.status(500).json({ error: "Error interno del servidor." });
      }
  
      const id_producto = result.insertId;
  
      const insertInventarioQuery = `INSERT INTO inventarios (id_producto, id_bodega, cantidad) VALUES (?, ?, ?)`;
      con.query(insertInventarioQuery, [id_producto, 1, cantidadInicial], (err) => {
        if (err) {
          console.error("Error al insertar en inventarios:", err);
          return res.status(500).json({ error: "Error interno del servidor." });
        }
  
        res.status(201).json({ mensaje: "Producto insertado con éxito." });
      });
    });
  });
  
/*  SELECT p.id, p.nombre, i.cantidad
  FROM productos p
  INNER JOIN inventarios i ON p.id = i.id

  UNION ALL

  SELECT NULL, NULL, SUM(cantidad)
  FROM inventarios

  ORDER BY id ASC, cantidad DESC */
export default storageProductos;
