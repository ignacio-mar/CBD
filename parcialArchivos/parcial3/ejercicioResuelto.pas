program Parcial;
const valorAlto=99999999;
   type
     detalle=record
       codProvincia:integer;
       codLocalidad:integer;
       votosValidos:integer;
       votosBlancos:integer;
       votosAnulados:integer;
     end;
     maestro=record
         codProvincia:integer;
         nombreProvincia:string[30];
         votosValidos:integer;
         votosBlancos:integer;
         votosAnulados:integer;
     end;
     archivoDetalle=file of detalle;
     archivoMaestro=file of maestro;
     archivosDetalle=array[1..500] of archivoDetalle;
     registrosDetalle=array[1..500] of detalle;


     procedure leer(var archivo:archivoDetalle;var  registro:detalle);
     begin
       if(not eof(archivo)) then
         read(archivo,registro);
       else
        registro.codProvincia:=valorAlto;
     end;
     procedure  minimo(var detalles:archivosDetalle; var registros:registrosDetalle; var min:detalle);
     var
      i,posMin:integer;
      begin
        posMin:=1;
        min:=registros[1];
        for i:=2 to 500 do begin
          if((registros[i].codProvincia<min.codProvincia) or (registros[i].codProvincia=min.codProvincia and registros[i].codLocalidad<min.codLocalidad)) then begin
              min:=registros[i];
              posMin:=i;
          end;
        end;
        leer(detalles[posMin],registros[posMin]);
      end;

      var
      archivo:archivoMaestro;
      detalles:archivosDetalle;
      archivoTexto:text;
      i,votosValidos,votosAnulados,votosBlancos:integer;
      nombre:string[30];
      min:detalle;
      registro:maestro;
    begin
      for i:=1 to 500 do begin
        writeln('escribe el nombre del archivo detalle');
        readln(nombre);
        assign(detalles[i],nombre);
      end;
      assign(archivo,'votosProvincia.dat');
      for i:=1 to 500 do begin
        reset(detalles[i]);
        leer(detalles[i],registros[i]);
        end;
      reset(archivo);
      minimo(detalles,registros,min);
      registro.codProvincia:=ValorAlto;
      assign(archivoTexto,'cantidad_votos_04_07_2023.txt');
      rewrite(archivoTexto);
      votosAnulados:=0;
      votosBlancos:=0;
      votosValidos:=0;
      while(min.codProvincia<>valorAlto) do begin
           while(min.codProvincia<>registro.codProvincia) do
             read(archivo,registro);
           while(min.codProvincia=registro.codProvincia) do begin
             registro.votosAnulados:=registro.votosAnulados+min.votosAnulados;
             registro.votosBlancos:=registro.votosBlancos+min.votosBlancos;
             registro.votosValidos:=registro.votosValidos+min.votosValidos;
             minimo(detalles,registros,min);
           end;
           votosAnulados:=votosAnulados+registro.votosAnulados;
           votosValidos:=votosValidos+registro.votosValidos;
           votosBlancos:=votosBlancos+registro.votosBlancos;
           seek(archivo,filePos(archivo)-1);
           write(archivo,registro);
      end;
      writeln(archivoTexto,'cantidad de archivos procesados: 500');
      writeln(archivoTexto,'cantidad total de votos: ',votosAnulados+votosValidos+votosBlancos);
      writeln(archivoTexto,'cantidad de votos validos: ',votosValidos);
      writeln(archivoTexto,'cantidad de votos anulados: ',votosAnulados);
      writeln(archivoTexto,'cantidad de votos en blanco: ',votosBlancos);
      close(archivo);
      close(archivoTexto);
      for i:=1 to 500 do
        close(detalles[i]);
    end;


