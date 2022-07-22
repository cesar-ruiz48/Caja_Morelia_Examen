<?php
class UserController extends BaseController
{
    /**
     * "Obtener lista de usuarios
     */
    public function listAction()
    {
        $strErrorDesc  = '';
        $requestMethod = $_SERVER["REQUEST_METHOD"];

        if (strtoupper($requestMethod) == 'GET') {
            try {
                $userModel = new UserModel();

                $arrUsers     = $userModel->getUsers();
                $responseData = json_encode($arrUsers, JSON_PRETTY_PRINT);
            } catch (Error $e) {
                $strErrorDesc   = $e->getMessage() . 'Something went wrong! Please contact support.';
                $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
            }
        } else {
            $strErrorDesc   = 'Method not supported';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        // send output
        if (!$strErrorDesc) {
            $this->sendOutput(
                $responseData,
                array('Content-Type: application/json', 'HTTP/1.1 200 OK')
            );
        } else {
            $this->sendOutput(json_encode(array('error' => $strErrorDesc)),
                array('Content-Type: application/json', $strErrorHeader)
            );
        }
    }

    public function listEdit()
    {
        $strErrorDesc         = '';
        $requestMethod        = $_SERVER["REQUEST_METHOD"];
        $arrQueryStringParams = $_SERVER["REQUEST_URI"];
        $id                   = explode('?', $arrQueryStringParams);

        if (strtoupper($requestMethod) == 'GET') {
            try {
                $userModel = new UpdateUser();

                if (isset($id[1]) && $id[1]) {
                    $name       = $_GET['name'];
                    $ap_paterno = $_GET['ap_paterno'];
                    $a_materno  = $_GET['a_materno'];
                    $curp       = $_GET['curp'];
                    $rfc        = $_GET['rfc'];
                    $id_cliente = $_GET['id_cliente'];
                }

                $arrUsers     = $userModel->updateUsers($name, $ap_paterno, $a_materno, $rfc, $curp, $id_cliente);
                $responseData = json_encode($arrUsers, JSON_PRETTY_PRINT);

            } catch (Error $e) {
                $strErrorDesc   = $e->getMessage() . 'Something went wrong! Please contact support.';
                $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
            }
        } else {
            $strErrorDesc   = 'Method not supported';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        // send output
        if (!$strErrorDesc) {
            $this->sendOutput(
                $responseData,
                array('Content-Type: application/json', 'HTTP/1.1 200 OK')
            );
        } else {
            $this->sendOutput(json_encode(array('error' => $strErrorDesc)),
                array('Content-Type: application/json', $strErrorHeader)
            );
        }
    }

    public function listDelete()
    {
        $strErrorDesc         = '';
        $requestMethod        = $_SERVER["REQUEST_METHOD"];
        $arrQueryStringParams = $_SERVER["REQUEST_URI"];
        $id                   = explode('?', $arrQueryStringParams);

        if (strtoupper($requestMethod) == 'GET') {
            try {
                $userModel = new UserDelete();
                if (isset($id[1]) && $id[1]) {
                    $id_valor = explode('=', $id[1]);
                    $id_valor = $id_valor[1];
                }
                $arrUsers     = $userModel->deleteUser($id_valor);
                $responseData = json_encode($arrUsers, JSON_PRETTY_PRINT);

            } catch (Error $e) {
                $strErrorDesc   = $e->getMessage() . 'Something went wrong! Please contact support.';
                $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
            }
        } else {
            $strErrorDesc   = 'Method not supported';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        // send output
        if (!$strErrorDesc) {
            $this->sendOutput(
                $responseData,
                array('Content-Type: application/json', 'HTTP/1.1 200 OK')
            );
        } else {
            $this->sendOutput(json_encode(array('error' => $strErrorDesc)),
                array('Content-Type: application/json', $strErrorHeader)
            );
        }
    }

    public function listCuentas()
    {
        $strErrorDesc         = '';
        $requestMethod        = $_SERVER["REQUEST_METHOD"];
        $arrQueryStringParams = $_SERVER["REQUEST_URI"];
        $id                   = explode('?', $arrQueryStringParams);

        if (strtoupper($requestMethod) == 'GET') {
            try {
                $userModel = new User_Cuentas();
                if (isset($id[1]) && $id[1]) {
                    $id = explode('=', $id[1]);
                    $id = $id[1];
                }

                $arrUsers     = $userModel->userCuentas($id);
                $responseData = json_encode($arrUsers, JSON_PRETTY_PRINT);

            } catch (Error $e) {
                $strErrorDesc   = $e->getMessage() . 'Something went wrong! Please contact support.';
                $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
            }
        } else {
            $strErrorDesc   = 'Method not supported';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        // send output
        if (!$strErrorDesc) {
            $this->sendOutput(
                $responseData,
                array('Content-Type: application/json', 'HTTP/1.1 200 OK')
            );
        } else {
            $this->sendOutput(json_encode(array('error' => $strErrorDesc)),
                array('Content-Type: application/json', $strErrorHeader)
            );
        }
    }

    public function listDatos()
    {
        $strErrorDesc         = '';
        $requestMethod        = $_SERVER["REQUEST_METHOD"];
        $arrQueryStringParams = $_SERVER["REQUEST_URI"];
        $id                   = explode('?', $arrQueryStringParams);

        if (strtoupper($requestMethod) == 'GET') {
            try {
                $userModel = new Mostrar_Datos();
                if (isset($id[1]) && $id[1]) {
                    $id = explode('=', $id[1]);
                    $id = $id[1];
                }

                $arrUsers     = $userModel->mostrarDatos($id);
                $responseData = json_encode($arrUsers, JSON_PRETTY_PRINT);

            } catch (Error $e) {
                $strErrorDesc   = $e->getMessage() . 'Something went wrong! Please contact support.';
                $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
            }
        } else {
            $strErrorDesc   = 'Method not supported';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';
        }

        // send output
        if (!$strErrorDesc) {
            $this->sendOutput(
                $responseData,
                array('Content-Type: application/json', 'HTTP/1.1 200 OK')
            );
        } else {
            $this->sendOutput(json_encode(array('error' => $strErrorDesc)),
                array('Content-Type: application/json', $strErrorHeader)
            );
        }
    }
}
