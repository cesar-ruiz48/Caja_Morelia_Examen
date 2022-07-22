<?php
require_once PROJECT_ROOT_PATH . "/Model/Database.php";

//METODO PARA MOSTRAR INFORMACION DE LOS CLIENTES DADOS DE ALTA
class UserModel extends Database
{
    public function getUsers($limit)
    {
        return $this->select("CALL tabla_clientes()");
    }
}

//METODO PARA ACTUALIZAR INFORMACION DE LOS CLIENTES
class UpdateUser extends Database
{
    public function updateUsers($nombre, $apellido_p, $apellido_p, $rfc, $curp, $id)
    {
        return $this->update("CALL update_cliente('$id','$nombre','$apellido_p','$apellido_p','$rfc','$curp')");
    }
}

//METODO PARA ELIMINAR AL CLIENTE SELECCIONADO
class UserDelete extends Database
{
    public function deleteUser($valor)
    {
        return $this->delete("CALL eliminar_cliente('$valor') ");
    }
}

//METODO PARA MOSTRAR INFORMACION DE LAS CUENTAS DE UN CLIENTE SELECCIONADO
class User_Cuentas extends Database
{
    public function userCuentas($id)
    {
        return $this->select("CALL informacion_cuentas('$id')");
    }
}

//METODO PARA MOSTRAR INFORMACION DEL CLIENTE SELECCIONADO
class Mostrar_Datos extends Database
{
    public function mostrarDatos($id)
    {
        return $this->select("CALL info_cliente('$id')");
    }
}
