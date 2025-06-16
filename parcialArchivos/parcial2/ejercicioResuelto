program Parcial;
const valorAlto=99999999;
   type
     venta=record
       dni:integer;
       anio:integer;
       mes:integer;
       dia:integer;
       codigo_marca:integer;
       codigo_modelo:integer;
       nombre_marca:string;
       nombre_modelo:string;
       color:string;
       monto:real;
     end;
     maestro=record
       anio:integer;
       mes:integer;
       montoTotal:real;
       cantidad:integer;
     end;
   archivoMaestro=file of maestro;
   archivoDetalle=file of venta;
   archivosDetalle=array[1..20] of archivoDetalle;
   registrosDetalle=array[1..20] of venta;

 procedure leer(var archivo:archivoDetalle; var registro:venta);
 begin
   if(not eof(archivo)) then
     read(archivo,registro);
   else
     registro.mes:= valorAlto;
 end;

 procedure minimo(var detalles:archivosDetalle; var registros:registrosDetalle; var min:venta);
 var
   posMin,i:integer;
 begin
   posMin:=1;
   min:=registros[1];
   for i=2 to 20 do begin
        if (registros[i].Anio < min.Anio) or
           ((registros[i].Anio = min.Anio) and (registros[i].Mes < min.Mes)) or
           ((registros[i].Anio = min.Anio) and (registros[i].Mes = min.Mes) and (registros[i].Dia < min.Dia)) or
           ((registros[i].Anio = min.Anio) and (registros[i].Mes = min.Mes) and (registros[i].Dia = min.Dia) and (registros[i].Codigo_Marca < min.Codigo_Marca)) or
           ((registros[i].Anio = min.Anio) and (registros[i].Mes = min.Mes) and (registros[i].Dia = min.Dia) and (registros[i].Codigo_Marca = min.Codigo_Marca) and (registros[i].Codigo_Modelo < min.Codigo_Modelo))  then begin
         min:=registros[i];
         posMin:=i;
       end;
   end;
   leer(archivosDetalle[posMin],registros[posMin]);
 end;

var
  detalles:archivosDetalle;
  registros:registrosDetalle;
  i,minVentas,maxVentas,dia,cantModelo,marca,modelo:integer;
  nombre,nomMarca,modeloMasVendido,modeloMenosVendido,nomModelo:string;
  min:venta;
  regMaestro:maestro;
  archivo:archivoMaestro;
  archivoTexto:text;
begin
  for i:=1 to 20 do begin
      Writeln('ingrese nombre fisico del archivo detalle');
      readln(nombre);
      assign(detalles[i],nombre);
  end;
    for i:=1 to 20 do begin
        reset(detalles[i]);
        leer(detalles[i],registros[i]);
    end;
    assign(archivo,'ventas.dat');
    rewrite(archivo);
    assign(archivoTexto,'datos.txt');
    rewrite(archivoTexto);
    minimo(detalles,registros,min);
    while(min.mes<>valoAlto)do begin
       regMaestro.anio:=min.anio;
       regMaestro.mes:=min.mes;
       regMaestro.montoTotal:=0;
       regMaestro.cantidad:=0;
       while(regMaestro.mes=min.mes)do begin
          dia:=min.dia;
          while(min.mes=regMaestro.mes and min.dia=dia) do begin
             marca:=min.codigo_marca;
             nomMarca:=min.nombre_marca;
             maxVentas:=-1;
             minVentas:=999999;
             while(min.mes=regMaestro.mes and dia=min.dia and marca=min.codigo_marca) do begin
               modelo:=min.codigo_modelo;
               nomModelo:=min.nombre_modelo;
               cantModelo:=0;
               while(min.mes=regMaestro.mes and dia=min.dia and marca=min.codigo_marca and modelo=min.codigo_modelo) do begin
                  cantModelo:=cantModelo+1;
                  regMaestro.montoTotal:=regMaestro.montoTotal+min.monto;
                  regMaestro.cantidad:=regMaestro.cantidad+1;
                  minimo(detalles,registros,min);
               end;
               if(cantModelo>maxVentas) then begin
                 maxVentas:=cantModelo;
                 modeloMasVendido:=nomModelo;
               end;
               if(cantModelo<minVentas) then begin
                 minVentas:=cantModelo;
                 modeloMenosVendido:=nomModelo;
               end;
             end;
            writeln(archivoTexto,nomMarca);
            writeln(archivoTexto,modeloMasVendido,maxVentas);
            writeln(archivoTexto,modeloMenosVendido,minVentas);
       end;
    end;
    write(archivo,regMaestro);
    end;
    close(archivo);
    close(archivoTexto);
    for i:=1 to 20 do
      close(detalles[i]);

end.
 
