 $(document).ready(function() {
     $.ajax({
         url: "Controller/Api/MethondCalls.php/user/listAction",
         /* Llamamos al archivo */
         type: "GET",
         contentType: "application/json",
         dataType: "json",
         /* Esto es lo que indica que la respuesta será un objeto JSon */
         success: function(data) {
             /* Inicializamos tabla */
             $("#cuerpo").html('');
             /* Vemos que la respuesta no este vacía y sea una arreglo */
             if (data != null && $.isArray(data)) {
                 /* Recorremos respuesta con each */
                 $.each(data, function(index, value) {
                     /* Vamos agregando a nuestra tabla las filas necesarias */
                     $("#cuerpo").append("<tr><td>" + value.id_cliente + "</td><td>" + value.nombre + "</td><td>" + value.alta + "</td><td>" + value.rfc + "</td><td><i data-toggle='modal' data-target='#exampleModalLong1' onclick='editar(" + value.id_cliente + ")' style='font-size: .6cm;' class='fa fa-pencil-square-o'></i>   <i onclick='alerta(" + value.id_cliente + ")' style='font-size: .6cm;' class='fa fa-trash-o'></i>   <i onclick='ver_informacion(" + value.id_cliente + ")' data-toggle='modal' data-target='#exampleModalLong'style='font-size: .6cm;' class='fa fa-info-circle'></i></td></tr>");
                 });
             }
         }
     });
 });

 function eliminar(id) {
     $.ajax({
         url: "Controller/Api/MethondCalls.php/user/listDelete",
         /* Llamamos al archivo */
         data: {
             'id': JSON.stringify(id)
         },
         type: "GET",
         contentType: "application/json",
         dataType: "json",
         /* Esto es lo que indica que la respuesta será un objeto JSon */
         success: function(data) {
             /* Inicializamos tabla */
             alert('El cliente se elimino Correctamente');
             location.reload();
         }
     });
 }

 function ver_informacion(id) {
     const formato = new Intl.NumberFormat('es-MX', {
         maximumFractionDigits: 2
     });
     $.ajax({
         url: "Controller/Api/MethondCalls.php/user/listCuentas",
         /* Llamamos al archivo */
         data: {
             'id': JSON.stringify(id)
         },
         type: "GET",
         contentType: "application/json",
         dataType: "json",
         /* Esto es lo que indica que la respuesta será un objeto JSon */
         success: function(data) {
             /* Inicializamos tabla */
             $("#cuentas").html('');
             /* Vemos que la respuesta no este vacía y sea una arreglo */
             if (data != null && $.isArray(data)) {
                 /* Recorremos respuesta con each */
                 $.each(data, function(index, value) {
                     /* Vamos agregando a nuestra tabla las filas necesarias */
                     $("#cuentas").append("<tr><td>" + value.cuenta + "</td><td>" + formato.format(value.saldo) + "</td><td>" + value.ASultimo + "</td></tr>");
                 });
             }
         }
     });
 }

 function editar(id) {
     $.ajax({
         url: "Controller/Api/MethondCalls.php/user/listDatos",
         /* Llamamos al archivo */
         data: {
             'id': JSON.stringify(id)
         },
         type: "GET",
         contentType: "application/json",
         dataType: "json",
         /* Esto es lo que indica que la respuesta será un objeto JSon */
         success: function(data) {
             $("#editar_usuario").html('');
             /* Vemos que la respuesta no este vacía y sea una arreglo */
             if (data != null && $.isArray(data)) {
                 /* Recorremos respuesta con each */
                 $.each(data, function(index, value) {
                     /* Vamos agregando a nuestra tabla las filas necesarias */
                     $("#editar_usuario").append("<div class='modal-body'><div class='col-sm-12'><div class='form-group'><b>Nombre</b><input  class='form-control require' type='text' id='name' name='name' value='" + value.nombre + "'></div></div><div class='col-sm-12'><div class='form-group'><b>Apellido Paterno</b><input class='form-control require' type='text' id='ap_paterno' name='ap_paterno' value='" + value.ap + "'></div></div><div class='col-sm-12'><div class='form-group'><b>Apellido Materno</b><input class='form-control require' type='text' id='a_materno' name='a_materno' value='" + value.am + "'></div></div><div class='col-sm-12'><div class='form-group'><b>CURP</b><input class='form-control require' type='text' id='curp' name='curp' value='" + value.curp + "'></div></div><div class='col-sm-12'><div class='form-group'><b>RFC</b><input class='form-control require' type='text' id='rfc' name='rfc' value='" + value.rfc + "'><input class='form-control require' type='hidden' id='id_cliente' name='id_cliente' value='" + value.id + "'></div></div></div>");
                 });
             }
         }
     });
 }

 function alerta(id) {
     var mensaje;
     var opcion = confirm("¿Deseas eliminar al cliente, se eliminaran tambien sus cuentas dadas de alta");
     if (opcion == true) {
         eliminar(id);
     }
 }

 function validarForm(idForm) {
     var rfc_normal = /^(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))/;
     var rfc_homoclave = /^(([A-Z]|[a-z]|\s){1})(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))/;
     var curp = /^([A-Z]|[a-z]|[0-9]+){18}$/;
     //Validamos cualquier input con la clase 'require'
     if ($(idForm + " input.require").val() == "") {
         alert("Faltan Datos Por Llenar");
         return false;
     } else if ($(idForm + " input[name='name'].require").length && !$(idForm + " input[name='name'].require").val()) {
         alert("Te falta llenar el Nombre");
         return false;
     } else if ($(idForm + " input[name='ap_paterno'].require").length && !$(idForm + " input[name='ap_paterno'].require").val()) {
         alert("Te falta llenar el Apellido Paterno");
         return false;
     } else if ($(idForm + " input[name='a_materno'].require").length && !$(idForm + " input[name='a_materno'].require").val()) {
         alert("Te falta llenar el Apellido Materno");
         return false;
     } else if ($(idForm + " input[name='curp'].require").length && !curp.test($(idForm + " input[name='curp'].require").val())) {
         alert("El CURP ingresado no es correcto");
         return false;
     } else if ($(idForm + " input[name='rfc'].require").length && !rfc_normal.test($(idForm + " input[name='rfc'].require").val()) && !rfc_homoclave.test($(idForm + " input[name='rfc'].require").val())) {
         alert("El RFC ingresado no es correcto ");
         return false;
     }
     //Devuelve true si todo está correcto
     else {
         return true;
     }
 }

 function envioAjax(url, idForm, method, capa) {
     event.preventDefault();
     var selectorjQform = "#" + idForm;
     var validado = validarForm(selectorjQform);
     if (validado) {
         $.ajax({
             url: url,
             method: method,
             data: $(selectorjQform).serialize(),
             dataType: 'html',
             error: function(jqXHR, textStatus, strError) {
                 alert("Error de conexión. Por favor, vuelva a intentarlo");
             },
             success: function(data) {
                 if (data) {
                     alert("Tu registro se actualizo Correctamente");
                     document.location.reload();
                 } else {
                     alert("Error inesperado. Por favor, vuelva a intentarlo");
                 }
             }
         });
     }
 }