MY_WALLET_PEM="wallet.pem"
PROXY="https://devnet-gateway.elrond.com"
CHAIN_ID="D"

WASM="../output/faction-sc.wasm"

# Mainnet SCs
LANNUVAR_ADDR="erd1qqqqqqqqqqqqqpgqjw0glp0mud67c46slx0m85gyt4ckssulkagqt4asqa"
KALUAK_ADDR="erd1qqqqqqqqqqqqqpgqpnj8u3jjvpvq7rq4vsjv3w7gdgzc5778kagqh7lvmc"
CENARION_ADRR="erd1qqqqqqqqqqqqqpgq57l7mg5e7mw6m2lctd87au568nkdu9kpkagqxe6rgm"
HODIR_ADDR="erd1qqqqqqqqqqqqqpgqnxs3jup9qj34hthmnxrarmhh69674en6kagqpzs99w"
IRONLIGHT_ADDR="erd1qqqqqqqqqqqqqpgqyun8mha8xerfypl3vdx2k2wgu233ca9lkagq9xak9g"

deploy() {
    erdpy --verbose contract deploy --recall-nonce \
        --bytecode=${WASM} \
        --pem=${MY_WALLET_PEM} \
        --metadata-payable \
        --proxy=${PROXY} --chain=${CHAIN_ID} \
        --gas-limit=10000000 \
        --send || return
}


# Fill this value before using below scripts
CONTRACT_ADDRES=""

upgrade() {
    erdpy --verbose contract upgrade ${CONTRACT_ADDRESS} --recall-nonce \
        --bytecode=${WASM} \
        --pem=${MY_WALLET_PEM} \
        --metadata-payable \
        --proxy=${PROXY} --chain=${CHAIN_ID} \
        --gas-limit=10000000 \
        --send || return
}

# $1 = address to withdraw to
# $2 = card nonce
withdrawCardTo() {
    erdpy --verbose contract call ${CONTRACT_ADDRESS} \
        --pem=${MY_WALLET_PEM} \
        --recall-nonce \
        --gas-limit 10000000 \
        --function "withdrawCardTo" \
        --arguments $1 $2 \
        --proxy=${PROXY} --chain=${CHAIN_ID} \
        --send || return
}

# $1 = address to withdraw to
# $2 = amount to withdraw. can be blank
withdrawEgldTo() {
    erdpy --verbose contract call ${CONTRACT_ADDRESS} \
        --pem=${MY_WALLET_PEM} \
        --recall-nonce \
        --gas-limit 10000000 \
        --function "withdrawEgldTo" \
        --arguments $1 $2 \
        --proxy=${PROXY} --chain=${CHAIN_ID} \
        --send || return
}
