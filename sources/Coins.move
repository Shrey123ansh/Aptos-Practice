module 0x42::Coins{

    use std::signer;

    struct Coins has store{ val : u64 }

    struct Balance has key{
        coins:Coins
    }

    const ERR_BALANCE_NOT_EXISTS: u64 = 101;
    const ERR_BALANCE_EXISTS: u64 = 102;

    public fun mint(val: u64):Coins{
        let new_coin = Coins{val};
        new_coin
    }
    public fun burn(coin : Coins){
        let Coins{val: _ } = coin;
    }

    public fun create_balancce(acc: &signer){
        let acc_addr = signer::address_of(acc);

        assert!(!balance_exists(acc_addr),ERR_BALANCE_EXISTS);

        let zero_coins = Coins{val:0};
        move_to(acc,Balance{coins : zero_coins});
    }

    public fun balance_exists(acc_addr: address):bool{
        exists<Balance>(acc_addr)
    }

    public fun deposit(acc_addr: address,coins:Coins) acquires Balance{
        assert!(balance_exists(acc_addr),ERR_BALANCE_NOT_EXISTS);

        let Coins{val} = coins;
        let balance = borrow_global_mut<Balance>(acc_addr);
        balance.coins.val = balance.coins.val + val;
    }

    public fun withdraw(acc: &signer,val : u64) acquires Balance{
        let acc_addr = signer::address_of(acc);
        assert!(balance_exists(acc_addr),ERR_BALANCE_NOT_EXISTS);

        let balance = borrow_global_mut<Balance>(acc_addr);
        balance.coins.val = balance.coins.val - val;
        //  Coins{ val }
    }
    
    public fun balance(acc_addr:address):u64 acquires Balance{
        borrow_global<Balance>(acc_addr).coins.val
    }


}