require 'simulador_cpu.rb'

def emuladorBonito(subrutina)
    memory = Memoria.new
    memory.cargarInstrucciones(subrutina)

    cpu = SimuladorCPU.new(43, 0)
    cpu.ejecutarInstrucciones(memory)
end