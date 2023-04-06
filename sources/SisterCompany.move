module 0x42::SisterCompany{
    friend 0x42::CompanyInfo;

    public fun get_company_name():vector<u8>{
    // public(friend) fun get_company_name():vector<u8>{
        return b"Sister Company"
    }
} 