module 0x42::Storage{
    use std::signer;
    // use Sender::Storage;

    struct Storage<T: store>has key{
        val: T,
    }

    fun store<T:store>(account: &signer,val: T){
        let addr = signer::address_of(account);
        assert!(!exists<Storage<T>>(addr),101);
        let to_store = Storage{
            val,
        };
        move_to(account,to_store);
    }

    public fun get<T: store>(account: &signer):T acquires Storage{
        let addr = signer::address_of(account);
        assert!(exists<Storage<T>>(addr),102);
        let Storage{val} = move_from<Storage<T>>(addr);
        val
    }

///// OR /////

    // fun store_bytes(account: signer,val: vector<u8>){
    //     Storage::store(&account,val);
    // }

}