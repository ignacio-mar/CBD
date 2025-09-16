program Project1;
type
   especie=record
     cod:integer;
     nom:string[30];
     altura_promedio:double;
     descripcion:string[80];
     zona:string[30];
   end;
 archivo_especie:file of especie;




 procedure eliminar_a(var archivo:archivo_especie; cod:integer);
 var
   dato:especie;
   begin
   reset(archivo);
   dato.cod=-1;
    while(not eof(archivo) and cod<>dato.cod) do
    read(archivo,dato);

    if(dato.cod=cod) then  begin
    dato.cod:=0;
    seek(archivo,filepos(archivo)-1);
    write(archivo,dato);
    end;
    close(archivo);
 end;
procedure compactar(var archivo:archivo_especie; var archivo_nuevo:archivo_especie);
var
  dato:especie;
  begin
   assign(archivo_nuevo,'archivo_compactado.dat');
   reset(archivo);
   rewrite(archivo_nuevo);
   while(not eof(archivo))do begin
     read(archivo,dato);
     if(dato.cod<>0) then
       write(archivo_nuevo,dato);
      end;
   close(archivo);
   close(archivo_nuevo);
  end;
procedure eliminar_b (var archivo:archivo_especie);
var
  aux,dato:especie:
    pos:integer;
  begin
  reset(archivo);
  dato.cod:=-1;
  while(not eof(archivo) and cod<>dato.cod) do
    read(archivo,dato);

    if(dato.cod=cod) then  begin
    pos:=filepos(archivo)-1;
    seek(archivo,filesize(archivo)-1);
    read(archivo,aux);
    seek(archivo,pos);
    write(archivo,aux);
    seek(archivo,filesize(archivo)-1);
    truncate(archivo);
    end;
  close(archivo);
end;


 var
    cod:integer;
    arhivo,archivo_nuevo:archivo_especie;
    numero:integer;

begin

assign(archivo,'archivo_especie.dat');
 writeln('INGRESE "1" PARA BAJA LOGICA, INGRESE "2" PARA BAJA FISICA');
 readln(numero);
 writeln('ingrese codigo a eliminar');
readln(cod);
while(cod<>100000)do begin
 case numero of
    1:begin
    eliminar_a(archivo,cod);
    compactar(archivo_nuevo,archivo);
    end:
  2: eliminar_b(archivo,cod);
end:
writeln('ingrese codigo a eliminar');
   readln(cod);
end;

end.

             
