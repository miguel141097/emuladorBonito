require 'instruccion.rb'

class Memoria

    def initialize
        @listaInstrucciones = Array.new
    end

    #Codifica las instrucciones y las carga en memoria
    def cargarInstrucciones(subrutina)
        subrutina.each do |instruccionFormateada|
            
            opcode = instruccionFormateada.split[0]
            operandos = instruccionFormateada.split[1]
            
            operando1 = nil
            operando2 = nil

            #Tiene operandos
            if(operandos != nil)
                operando1 = operandos.split(',')[0]
                operando2 = operandos.split(',')[1]

                #Diferenciar dos funciones MOV(Registro o Constante)
                if(opcode == "MOV")
                    if(operando1[0] != 'R')
                        opcode = "MOV_D"
                    else
                        opcode = "MOV_RXX"
                    end
                end
                
                operando1 = operando1.delete_prefix('R').to_i
                if(operando2 != nil)
                    operando2 = operando2.delete_prefix('R').to_i
                end

            end

            instruccion = Instruccion.new(opcode, operando1, operando2)
            @listaInstrucciones << instruccion

        end
    end

    #Retorna nil (nulo) si no existe esa dirección de memoria
    def getInstruccion(dir)
        @listaInstrucciones[dir]
    end

end