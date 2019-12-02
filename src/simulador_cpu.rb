require 'memoria.rb'

class SimuladorCPU

    MAX_NUMBER = (2 ** 32) - 1
    MIN_NUMBER = 0

    def initialize(numRegistros, posPC)
        @registros = Array.new(numRegistros, 0)
        @posPC = posPC
    end

    def mov_registro(rxx, ryy)
        @registros[ryy] = @registros[rxx]
    end

    def mov_constante(d, rxx)
        @registros[rxx] = d
    end

    def add(rxx, ryy)
        @registros[rxx] = (@registros[rxx] + @registros[ryy]) % (MAX_NUMBER + 1)
    end

    def dec(rxx)
        if(@registros[rxx] == MIN_NUMBER)
            @registros[rxx] = MAX_NUMBER
        else
            @registros[rxx] -= 1
        end
    end

    def inc(rxx)
        if(@registros[rxx] == MAX_NUMBER)
            @registros[rxx] = MIN_NUMBER
        else
            @registros[rxx] += 1
        end
    end

    def inv(rxx)
        @registros[rxx] = MAX_NUMBER - @registros[rxx]
    end

    def jmp(d)
        @posPC = d - 1
    end

    def jz(d)
        if(@registros.first == MIN_NUMBER)
            @posPC = d - 1
        end
    end

    def ejecutarInstrucciones(memoria)

        #Es un puntero a la instrucción actual
        programCounter = memoria.getInstruccion(@posPC)

        while(programCounter != nil)

            @posPC += 1

            case programCounter.opcode
            
                when "MOV_RXX"
                    mov_registro(programCounter.operando1, programCounter.operando2)
                when "MOV_D"
                    mov_constante(programCounter.operando1, programCounter.operando2)
                when "ADD"
                    add(programCounter.operando1, programCounter.operando2)
                when "DEC"
                    dec(programCounter.operando1)
                when "INC"
                    inc(programCounter.operando1)
                when "INV"
                    inv(programCounter.operando1)
                when "JMP"
                    jmp(programCounter.operando1)
                when "JZ"
                    jz(programCounter.operando1)

            end

            #Actualiza el puntero
            programCounter = memoria.getInstruccion(@posPC)

        end

        return @registros.last

    end

    private :mov_registro, :mov_constante, :add, :dec, :inc, :inv, :jmp, :jz

end