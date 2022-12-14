create database final_project

use final_project


create Table Category (
	cid varchar(10) primary key,
	cname nvarchar(255),
	slug varchar(255),
)

create table Product (
    pid varchar(10) primary key,
    pname nvarchar(255),
    price int,
    image varchar(255),
    description nvarchar(255),
    brand nvarchar(255),
    weight nvarchar(255),
	cid varchar(10),
    nImport int, 
    nExport int,
	createdAt date,
	slug varchar(255),
	constraint CHECK_IMPORT_EXPORT Check (nImport >= nExport),
	constraint FK_Category_Product_CID foreign key (cid) references Category (cid)
)

create table Account (
    acc_id varchar(10) primary key,
    password varchar(255),
    type varchar(255) Check (type in ('Admin', 'Partner')),
)

create table Admin (
	acc_id varchar(10),
	name nvarchar(255),
	email varchar(255),
	Primary key (acc_id, name),
	constraint FK_Account_Admin foreign key (acc_id) references Account (acc_id)
)

--Select P.pid, P.pname as p_name, P.price, ED.quantity, E.createdAt, E.total, E.acc_id, C.name as customer_name, C.phone, C.email, C.address 
--From Export E, Product P, ExportDetail ED, Customer C
--Where C.customer_id = E.customer_id And P.pid = ED.pid And ED.exp_id = E.exp_id And E.exp_id = 'E001'

create table Customer (
	customer_id varchar(10) primary key,
	type varchar(10) Check (type in ('Individual','Partner')),
	name nvarchar(255),
    phone char(10),
    address nvarchar(255),
    email varchar(255),
	note nvarchar(255),
	discount int,
	acc_id varchar(10) NULL,
	constraint FK_Account_Customer foreign key (acc_id) references Account (acc_id)
)

create table Import (
    imp_id varchar(10) primary key,
    total int,
    createdAt date,
    status varchar(255),
    acc_id varchar(10),
    constraint FK_ACCOUNT_IMPORT_ACCID foreign key (acc_id) references Account (acc_id)
)

Select P.pid, P.pname, P.price , sum(ED.quantity) as quantity  from Export E, ExportDetail ED, Product P 
Where ED.pid = P.pid And E.exp_id = ED.exp_id And  E.createdAt >= '12-12-2022'
	Group by  P.pid, P.pname, P.price
	Order by sum(ED.quantity) desc

create table ImportDetail (
    imp_id varchar(10),
    pid varchar(10),
	quantity int,
	price int
    primary key (imp_id, pid),
    constraint FK_IMPORT_IMPORTDETAIL_IMPID foreign key (imp_id) references Import(imp_id),
    constraint FK_PRODUCT_IMPORTDETAIL_PID foreign key (pid) references Product(pid)
)

create table Export (
    exp_id varchar(10) primary key,
    total int,
    createdAt date,
    status nvarchar(255),
	customer_id varchar(10),
    acc_id varchar(10),
	constraint FK_CUSTOMER_EXPORT_CUSTOMERID foreign key (customer_id) references Customer (customer_id),
    constraint FK_ACCOUNT_EXPORT_ACCID foreign key (acc_id) references Account (acc_id)
)


create table ExportDetail (
    exp_id varchar(10),
    pid varchar(10),
	quantity int,
	price int,

    primary key (exp_id, pid),
    constraint FK_EXPORT_EXPORTDETAIL_EXPID foreign key (exp_id) references Export (exp_id),
    constraint FK_PRODUCT_EXPORTDETAIL_PID foreign key (pid) references Product (pid)
)

create table Orders (
	order_id varchar(10) primary key,
	total int,
	createdAt date,
	status nvarchar(255),
	customer_id varchar(10),
	constraint CHECK_STATUS Check (status in ('Success', 'Pending', 'Fail')),
	constraint FK_Customer_Order foreign key (customer_id) references Customer (customer_id)
)


create table OrderDetail (
	order_id varchar(10),
	pid varchar(10),
	quantity int,
	price int,

	Primary key (order_id, pid),
	Constraint FK_ORDERS_ORDERDETAIL foreign key (order_id) references Orders (order_id),
	Constraint FK_PRODUCT_ORDERDETAIL foreign key (pid) references Product (pid)
)

-- INSERT CATEGORY --
insert into Category values ('WP', 'Whey Protein', 'whey-protein')
insert into Category values ('CP', 'Casein Protein', 'casein-protein')
insert into Category values ('HWP', 'Hydrolyzed Whey Protein', 'hydrolyzed-whey-protein')
insert into Category values ('MR', 'Meal Replacement', 'meal-replacement')
insert into Category values ('PB', 'Protein Bar', 'protein-bar')
insert into Category values ('VP', 'Vegan Protein', 'vegan-protein')
-- END --


-- INSERT PRODUCT --
insert into Product values (
	'8925004050',
	'Rule 1 Proteins 5Lbs (2.23kg)',
	1830000,
	'/img/WP/wp1.png', 
	N'Whey Rule 1 Protein là sản phẩm phát triển cơ bắp cung cấp 100% Whey Isolate và Hydrolyzed hấp thu nhanh. Whey Rule 1 protein nhập khẩu chính hãng, cam kết chất lượng, giá rẻ nhất tại Hà Nội & Tp.HCM.',
	'Rule 1',
	'5Lbs ~ 2.27kg',
	'WP',
	300,
	202,
	'2022-12-10',
	'rule-1-proteins-5lbs-2.23kg'
)
insert into Product values (
	'0516031203',
	'Whey ISO HD 4.9Lbs (2.2kg)',
	1580000,
	'/img/WP/wp2.png', 
	N'Whey BPI ISO HD là sản phẩm 100% Whey Isolate hỗ trợ phục hồi, phát triển cơ bắp hiệu quả. Cam kết nhập khẩu chính hãng uy tín và giá rẻ nhất tại Hà Nội, TpHCM.',
	'BPI Sport',
	'4.9Lbs ~ 2.2kg',
	'WP',
	180,
	30,
	'2022-12-10',
	'whey-iso-hd-4.9lbs-2.2kg'
)
insert into Product values (
	'8927028669',
	'Whey Gold Standard 5Lbs (2.3kg)',
	1790000,
	'/img/WP/wp3.png', 
	N'Whey Gold Standard 100% là sản phẩm Whey tăng cơ với hơn 30 năm uy tín thương hiệu hàng đầu thế giới,cam kết chính hãng, chất lượng và giá rẻ nhất Hà Nội, TpHCM',
	'Optimum Nutrition',
	'5Lbs ~ 2.27KG',
	'WP',
	150,
	123,
	'2022-12-10',
	'whey-gold-standard-5lbs-2.3kg'
)
insert into Product values (
	'8927026382',
	'Platinum HydroWhey 3.5Lbs (1.59kg)',
	1900000,
	'/img/HWP/hwp1.png', 
	N'Platinum HydroWhey ON là sản phẩm tăng cơ bắp hiệu quả nhất với 100% Whey thủy phân hấp thu nhanh, chính hãng Optimum Nutrition và giá tốt nhất tại Hà Nội TPHCM.',
	'Optimum Nutrition',
	'3.5Lbs ~ 1.59kg',
	'HWP',
	150,
	25,
	'2022-12-10',
	'platinum-hydrowhey-3.5lbs-1.59kg'
)
insert into Product values (
	'2723026351',
	'Labrada Lean Pro 8 5Lbs (2.3kg)',
	1690000,
	'/img/MR/mr1.png', 
	N'Bữa ăn nhanh, thông minh với Labrada Lean Pro 8 5lbs (2,27kg) sẽ giúp cho cơ bắp của bạn lớn hơn, mạnh mẽ hơn và gọn gàng nhanh chóng hơn bao giờ hết.',
	'Labrada',
	'5lbs ~ 2.27kg',
	'MR',
	120,
	25,
	'2022-12-10',
	'labrada-lean-pro-8-5lbs-2.27kg'
)

insert into Product values (
	'7933024011',
	'Mutant Iso Surge 5Lbs (2.3kg)',
	1690000,
	'/img/HWP/hwp2.png', 
	N'Mutant ISO Surge là sản phẩm 100% Whey Isolate & Hydrolysate phát triển cơ bắp nhanh nhất, với hơn 15 hương vị lựa chọn, chính hãng uy tín và giá rẻ tại Hà Nội TpHCM.',
	'Mutant',
	'5Lbs ~ 2.23kg',
	'HWP',
	150,
	28,
	'2022-10-10',
	'mutant-iso-surge-5lbs-2.3kg'
)

insert into Product values (
	'4233664071',
	'Boosted Plant Protein (840g)',
	950000,
	'/img/VP/vp1.png', 
	N'Boosted Plant Protein bổ sung 100% Protein Organic cho người thuần chay cùng 1 tỷ lợi khuẩn tốt cho tiêu hoá. Boosted Plant Protein nhập khẩu chính hãng, giá rẻ tốt nhất Hà Nội TpHCM.',
	'North Coast Naturals',
	'1.85Lbs ~ 840g',
	'VP',
	250,
	120,
	'2022-10-15',
	'boosted-plant-protein-840g'
)

insert into Product values (
	'4533224954',
	'BiotechUSA Vegan Protein (500g)',
	600000,
	'/img/VP/vp2.png', 
	N'BiotechUSA Vegan Protein bổ sung nguồn protein thực vật hỗ trợ ăn chay, phát triển cơ bắp. Sản phẩm nhập khẩu chính hãng, cam kết giá rẻ tốt nhất Hà Nội TpHCM.',
	'Biotech USA',
	'1.1Lbs ~ 500g',
	'VP',
	50,
	20,
	'2022-10-17',
	'biotechusa-vegan-protein-500g'
)

insert into Product values (
	'4854739344',
	'Ostrovit Vege Protein Blend (700g)',
	670000,
	'/img/VP/vp3.png', 
	N'Ostrovit Vege Protein bổ sung 100% Vegan Protein thực vật hỗ trợ xây dựng cơ bắp, cải thiện sức khoẻ cho người ăn chay. Sản phẩm nhập khẩu chính hãng, giá rẻ tốt nhất Hà Nội TpHCM.',
	'Ostrovit',
	'1.1Lbs ~ 700g',
	'VP',
	130,
	77,
	'2021-6-17',
	'ostrovit-vege-protein-blend-700g'
)

insert into Product values (
	'3754903863',
	'Gold Standard 100% Casein 4Lbs (1.8kg)',
	1970000,
	'/img/CP/cp1.png', 
	N'Gold Standard Casein ON hỗ trợ nuôi cơ ban đêm, chống dị hóa và phát triển cơ bắp hiệu quả. Sản phẩm nhập khẩu chính hãng, cam kết giá rẻ tốt nhất Hà Nội TpHCM.',
	'Optimum Nutrition',
	'4Lbs ~ 1.8kg',
	'CP',
	80,
	58,
	'2022-4-25',
	'gold-standard-casein-4lbs-1.8kg'
)
delete from product where pid = '3756453123'
insert into Product values (
	'3756453123',
	'Rule 1 Casein Strong 4Lbs (1.81kg)',
	1450000,
	'/img/CP/cp2.png', 
	N'Rule 1 Casein nuôi cơ ban đêm trải dài 8 tiếng, phục hồi và phát triển cơ bắp hiệu quả. Sản phẩm nhập khẩu chính hãng, cam kết chất lượng, giá rẻ nhất tại Hà Nội & Tp.HCM.',
	'Rule 1',
	'5lbs',
	'CP',
	70,
	70,
	'2022-6-25',
	'rule-1-casein-strong-4lbs-1.81kg'
)

insert into Product values (
	'9245725833',
	'Lean Body MRP 80 Package',
	4400000,
	'/img/MR/mr2.png', 
	N'Lean Body MRP 80 gói là sản phẩm cung cấp dinh dưỡng thay thế bữa ăn phụ thông minh, hỗ trợ tăng cơ giảm mỡ của hãng Labrada, giá rẻ tại Hà Nội , TpHCM…',
	'Labrada',
	'80 Package',
	'MR',
	180,
	158,
	'2022-4-25',
	'lean-body-mrp-80-package'
)
-- END --


-- INSERT ACCOUNT --
insert into Account values ('JK-ADMIN', 'qwerty', 'Admin')
insert into Account values ('JK-ADMIN2', 'qwerty', 'Admin')
insert into Account values ('WH-3901', '9952811', 'Partner')
insert into Account values ('AW-3956', '123456', 'Partner')
-- END --

-- INSERT ADMIN --
insert into Admin values ('JK-ADMIN', N'Kuo Nhan Dung', 'nkeyskuo124@gmail.com')
insert into Admin values ('JK-ADMIN2', N'Chu Trần Gia Bảo', 'jack@gmail.com')
-- END --

-- INSERT CUSTOMER --
insert into Customer values (
	'CS0001',
	'Partner',
	N'Công Ty Thương Mại Cổ Phần Dịch Vụ Tân Á Quân',
	'0985247531',
	N'94 Nguyễn Oanh Phường 10, Quận Gò Vấp',
	'thuongmaitanaquan@gmail.com',
	N'Đối tác chiến lượt 2022-2023',
	13,
	'AW-3956'
)

insert into Customer values (
	'CS0002',
	'Partner',
	N'Công Ty Trách Nhiệm Hữu Hạn Whey Handle',
	'0763932852',
	N'80/13 Hoàng Hoa Thám Phường 5, Quận Tân Bình',
	'wheyhandlecomp@gmail.com',
	N'Đối tác chiến lượt 2022-2023',
	20,
	'WH-3901'
)
insert into Customer values (
	'CS0003',
	'Individual',
	N'Nguyễn Hoàng Quốc Bảo',
	'0903740813',
	N'429 Nguyễn Kiệm Phường 9, Quận Phú Nhuận',
	'baoquochoang@gmail.com',
	N'',
	0,
	null
)
-- END --

-- INSERT IMPORT -- 
insert into Import values ('I001', 2900000, GETDATE(), 'Pending', 'JK-ADMIN')
insert into Import values ('I002', 5100000, GETDATE(), 'Success', 'JK-ADMIN2')
insert into ImportDetail values ('I001', '8925004050', 3, 10000)
insert into ImportDetail values ('I001', '0516031203', 2, 30000)
insert into ImportDetail values ('I002', '0516031203', 5, 0)

select * from Import
-- END --

-- INSERT EXPORT --

insert into Export values ('E002',20500000, GETDATE(), N'Pending', 'CS0002', 'JK-ADMIN2')
insert into ExportDetail values ('E002', '8925004050', 30, 1580000)
insert into ExportDetail values ('E002', '8927028669', 50, 1900000)
insert into ExportDetail values ('E002', '0516031203', 100, 1790000)
insert into ExportDetail values ('E002', '2723026351', 20, 1690000)
-- END --

-- INSERT ORDER --
insert into Orders values ('Ord002', 7500000, GETDATE(), 'Pending', 'CS0003')
insert into OrderDetail values ('Ord002', '8927026382', 2, 1900000)
insert into OrderDetail values ('Ord002', '8925004050', 3, 1830000)
insert into OrderDetail values ('Ord002', '0516031203', 1, 1580000)
-- END

select * From account