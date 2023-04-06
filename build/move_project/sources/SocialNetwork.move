module 0x42::SocialNetwork
{
    // use std::debug;
    use std::vector;

    struct Friends has store, key, drop
    {
        people: vector<Person>
    }

    struct Person has store, key, drop , copy
    {
        name: vector<u8>,
        age: u8,
    }

    public fun create_friend(myFriend: Person,friends: &mut Friends): Person{
        let newFriend = Person{
            name: myFriend.name,
            age: myFriend.age
            };
        add_friend(newFriend,friends);
        return newFriend
    }

    public fun add_friend(myFriend: Person,friends: &mut Friends){
        vector::push_back(&mut friends.people,myFriend)
    }

    #[test]
    fun test_create_friend()
    {
        let richand = Person{
            name: b"Richard",
            age: 31,
        };
        let friends = Friends{
            people : (vector[richand])
        };
        let createdFriend = create_friend(richand,&mut friends);
        assert!(createdFriend.name == b"Richard",0)
    }
}