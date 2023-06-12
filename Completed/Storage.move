module 0x42::Storages{
    use std::signer;

    const ERROR: u64 = 101;

    struct Storage<T: store>has key{
        val: T,
    }

    fun store<T:store>(account: &signer,val: T){
        let addr = signer::address_of(account);
        assert!(!exists<Storage<T>>(addr),ERROR);
        let to_store = Storage{
            val,
        };
        move_to(account,to_store);
    }

    public fun get<T: store>(account: &signer):T acquires Storage{
        let addr = signer::address_of(account);
        assert!(exists<Storage<T>>(addr),ERROR);
        let Storage{val} = move_from<Storage<T>>(addr);
        val
    }


    #[test(account=@0x123)]
    fun test_store_u128(account: signer) acquires Storage{
        let value: u128 = 100;
        store(&account,value);
        assert!(value == get<u128>(&account),ERROR)
    }

}