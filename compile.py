from os import getcwd, system

def compile(mealy: bool):
    system(
        f'iverilog -o {getcwd()}/output/{"mealy" if mealy else "moore"}/{"mealy" if mealy else "moore"}.out {getcwd()}/test/testbench_{"mealy" if mealy else "moore"}.v'
    )
    system(f'vvp {getcwd()}/output/{"mealy" if mealy else "moore"}/{"mealy" if mealy else "moore"}.out > {getcwd()}/output/{"mealy" if mealy else "moore"}/{"mealy" if mealy else "moore"}.csv')
    system(f'rm -rf {getcwd()}/output/{"mealy" if mealy else "moore"}/{"mealy" if mealy else "moore"}.out')

if __name__ == "__main__":
    compile(mealy=True)
    compile(mealy=False)