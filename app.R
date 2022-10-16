print(RWrapperMiscellaneousPkg::hello_world())


print(RWrapperMiscellaneousPkg::add_num(5,3))


print(RWrapperMiscellaneousPkg::mul_num(5, 3))


print(RWrapperMiscellaneousPkg::mod_num(5, 3))


print(RWrapperMiscellaneousPkg::levenshtein('hallo welt', 'hallo test'))


print(RWrapperMiscellaneousPkg::hamming_smid('00110', '00100'))

print(RWrapperMiscellaneousPkg::bom_matching('00110', '00110'))



print(RWrapperMiscellaneousPkg::bndm_matching('00110', '00110'))



print(RWrapperMiscellaneousPkg::horspool_matching('00110', '00110'))


print(RWrapperMiscellaneousPkg::kmp_matching('00110', '00110'))


print(RWrapperMiscellaneousPkg::hamming('00110','00110'))


print(RWrapperMiscellaneousPkg::get_sha224("Hallo Welt"))


print(RWrapperMiscellaneousPkg::get_sha384("hallo Welt"))


print(RWrapperMiscellaneousPkg::get_sha512("hallo Welt"))


print(RWrapperMiscellaneousPkg::get_sha1("hallo Welt"))


print(RWrapperMiscellaneousPkg::get_random_number_range(0, 5000))


print(RWrapperMiscellaneousPkg::send_custom_http_request('https://httpbin.org/get','GET',list(),list(),list(),""))

RWrapperMiscellaneousPkg::resize_image('20220824_214140.jpg',500,500,'Nearest','20220824_214140_nearest.jpg',TRUE)
RWrapperMiscellaneousPkg::resize_image('20220824_214212.jpg',500,500,'Triangle','20220824_214212_triangle.jpg',TRUE)
RWrapperMiscellaneousPkg::resize_image('20220824_214215.jpg',500,500,'CatmullRom','20220824_214215_catmullRom.jpg',TRUE)
RWrapperMiscellaneousPkg::resize_image('20220824_214219.jpg',500,500,'Gaussian','20220824_214219_gaussian.jpg',TRUE)
RWrapperMiscellaneousPkg::resize_image('20220824_214217.jpg',500,500,'Lanczos3','20220824_214217_lanczos3.jpg',TRUE)


inputStr <- "<dataset>
                   <record>
                       <id>1</id>
                        <first_name>Nerita</first_name>
                         <last_name>Stanney</last_name>
                         <email>nstanney0@domainmarket.com</email>
                         <gender>Female</gender>
                         <ip_address>223.10.217.33</ip_address>
                    </record>
       </dataset>"
print(RWrapperMiscellaneousPkg::xml_to_json(inputStr))

RWrapperMiscellaneousPkg::read_sheet_by_name("example_input.xlsx", "Test1")
RWrapperMiscellaneousPkg::write_sheet_by_name('example.xlsx',"Test1",jsonlite::toJSON(mtcars))