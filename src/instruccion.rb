class Instruccion

    attr_reader :opcode, :operando1, :operando2

    def initialize(opcode, operando1, operando2)
        @opcode = opcode
        @operando1 = operando1
        @operando2 = operando2
    end

end