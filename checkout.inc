############
# Checkout #
############
    co = checkout
    # Checkout --track -b
    cob = !"f() { echo \"Checkout branch origin/$1\"; git checkout --track -b $1 origin/$1; }; f"

