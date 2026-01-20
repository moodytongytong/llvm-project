class Inst<string mnemonic, int opcode> {
    string Mnemonic = mnemonic;
    int Opcode = opcode;
    bit Commutable = 0;
}

class CommutableInst<string mnemonic, int opcode> : Inst<mnemonic, opcode> {
    let Commutable = 1;
}

def ADD: CommutableInst<"add", 0xA0>;
def SUB: Inst<"sub", 0xB0>;