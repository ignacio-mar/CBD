program Parcial;
   type
     prestamo=record
       dni:integer;
       nombre_apellido:string[50];
       codigo:integer;
       descripcion:string[100];
       fecha:string[50];
     end;
 archivoPrestamos=file of prestamo;

 procedure altaRegistro(var archivo:archivoPrestamos);
 var
   registro,registroCabecera:prestamo;
   begin
     writeln('ingrese dni');
     readln(registro.dni);
     writeln('ingrese nombre y apellido');
     readln(registro.nombre_apellido);
     writeln('ingrese codigo de herramienta');
     readln(registro.codigo);
     writeln('ingrese descripcion');
     readln(registro.descripcion);
     writeln('ingrese fecha del prestamo');
     readln(registro.fecha);
     reset(archivo);
     read(archivo,registroCabecera);
     if(registroCabecera.dni<0)then begin
       seek(,archivo,-registroCabecera.dni);
       read(archivo,registroCabecera);
       seek(archivo,filePos(archivo)-1);
       write(archivo,registro);
       seek(archivo,0);
       write(archivo,registroCabecera);
       end
     else begin
      seek(archivo,fileSize(archivo));
      write(archivo,registro);
     end;
     close(archivo);

   end;
procedure bajaRegistro( var archivo:archivoPrestamos);
 var
   dni:integer;
   codigo,posBorrar:integer;
   fecha:string[50];
   registroCabecera,registro:prestamo;
   encontre:boolean;
   archivoTexto:text;
begin
  assign(archivoTexto,'bajas_prestamos.txt');
  append(archivoTexto);
  writeln('ingrese dni');
  readln(dni);
  writeln('ingrese codigo');
  readln(codigo);
  writeln('ingrese fecha');
  readln(fecha);
  reset(archivo);
  read(archivo,registroCabecera);
  encontre:=false;
  while(not eof(archivo) and not encontre) do begin
    read(archivo,registro);
    if(registro.dni=dni and registro.codigo=codigo and registro.fecha=fecha) then
      encontre:=true;
  end;
  if(encontre) then begin
    writeln(archivoTexto,registro.dni,registro.nombre_apellido,registro.codigo,registro.descripcion,registro.fecha);
    posBorrar:=filePos(archivo)-1;
    registro.dni:=-posBorrar;
    seek(archivo,posBorrar);
    write(archivo,registroCabecera);
    seek(archivo,0);
    write(archivo,registro);
  end
  else writeln('no se pudo encontrar');
  close(archivo);
  close(archivoTexto);

end;

begin
end.
                           
