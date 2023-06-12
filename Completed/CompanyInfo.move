module 0x42::CompanyInfo
{
    // use std::debug;

    const CONTRACT:address = @0x42;

    struct Info has drop
    {
        company_name: vector<u8>,
        owns: vector<u8>
    }

    public fun get_Info(): Info {
        let sisterCompanyName = 0x42::SisterCompany::get_company_name();

        let info = Info{
            company_name: b"the comapany",
            owns: sisterCompanyName,
        };
        return info
    }

    #[test]
    fun test_get_Info()
    {
        let check_info = Info{
            company_name: b"Richard",
            owns: b"Sister Company"
        };
        let real_info = get_Info();

        assert!(check_info.owns == real_info.owns,0);
    }
}

module 0x42::SisterCompany{
    friend 0x42::CompanyInfo;

    // public fun get_company_name():vector<u8>{
    public(friend) fun get_company_name():vector<u8>{
        return b"Sister Company"
    }
} 