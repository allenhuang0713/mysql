-- 0. 創立 資料庫 iii
create database iii;

-- 1. 創立 客戶 資料表
create table Customers ( cID int unsigned primary key auto_increment
, cName varchar(100), cPhone varchar(100)
unique key, cEmail varchar(100), cAddress varchar(100)); --主鍵

-- 2. 創立 供應商 資料表
create table Suppliers ( sID int unsigned primary key auto_increment, sName varchar(100), sPhone varchar(100)
unique key, sAddress varchar(200));

-- 3. 創立 商品表 資料表
create table Products ( pID int unsigned primary key auto_increment, pNumber varchar(100) unique key, pName va
rchar(100), pRPrice varchar(100), pCompanyName varchar(100));

-- 3.1 創立 商品表外鍵 連 供應商電話 
alter table products add foreign key (pcompanyname) references suppliers (sphone); --外鍵

-- 4. 創立 訂單 資料表
create table Orders ( oID int unsigned primary key auto_increment, oNumber varchar(100) unique key, oCustomer 
varchar(100),foreign key (oCustomer) references Customers (cPhone));

-- 5. 創立 訂單細項 資料表
create table ODetails ( odID int unsigned primary key auto_increment, odNumber varchar(100), odproduct varchar(100)
, odAPrice varchar(100), odQuantity varchar(100),foreign key (odNumber) references Orders (oNumber),foreign key (odproduct) 
references Products (pNumber));

-- 6.1 客戶 新增
\d #
create procedure cins(in newcid int, newcname varchar(100), newcphone varchar(100),
newcEmail varchar(100), newcAddress varchar(100))
begin
    insert into Customers (cID,cName,cPhone,cEmail,cAddress)
    values (newcid,newcname,newcphone,newcEmail,newcAddress); --給值建立客戶表
end #
\d ;
-- 6.2 客戶 刪除
\d #
create procedure cdel(in kw int)
begin
    delete from customers where cID = kw; -- 指定ID刪除
end #
\d ;
-- 6.3 客戶 修改
\d #
create procedure cupd(in kw int, newname varchar(100), newphone varchar(100), newemail varchar(100),
newaddress varchar(100))
begin
    update customers 
    set 
    cName = newname,
    cPhone = newphone,
    cEmail = newemail,
    cAddress = newaddress
    where cID = kw; -- 指定ID新增
end #
\d ;
-- 6.4 查詢 客戶 電話
\d #
create procedure cinphone (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; --設定字串
    if (select count(*) from customers where cphone like @key) = 0 then --沒有關鍵字之判斷
    	SELECT * FROM customers;
    else 
    	select * from Customers where cPhone like @key; --查詢關鍵字
    end if;
end
\d ;
-- 6.5 查詢 客戶 姓名
\d #
create procedure cinname (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    if (select count(*) from customers where cname like @key) = 0 then
    	SELECT * FROM customers;
    else 
    	select * from Customers where cname like @key;
    end if;
end
\d ;

-- 7.1 供應商 新增
\d #
create procedure sins(in newid int, newname varchar(100), newphone varchar(100)
, newAddress varchar(100))
begin
    insert into suppliers (sID,sName,sPhone,sAddress) 
    values (newid,newname,newphone,newAddress); 
end #
\d ;
-- 7.2 供應商 刪除
\d #
create procedure sdel (in kw int)
begin
    delete from suppliers where sID = kw; 
end #
\d ;
-- 7.3 供應商 修改
\d #
create procedure supd(in kw int, newname varchar(100), newphone varchar(100),
newaddress varchar(100))
begin
    update suppliers 
    set 
    sName = newname,
    sPhone = newphone,
    sAddress = newaddress
    where sID = kw; -- 指定ID新增
end #
\d ;
-- 7.4 查詢 供應商 電話
\d #
create procedure sinphone (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    if (select count(*) from suppliers where sphone like @key) = 0 then
    	SELECT * FROM suppliers;
    else 
    	select * from suppliers where sPhone like @key;
    end if;
end #
\d ;
-- 7.5 查詢 供應商 名稱
\d #
create procedure sinname (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    if (select count(*) from suppliers where sName like @key) = 0 then
    	SELECT * FROM suppliers;
    else 
    	select * from suppliers where sName like @key;
    end if;
end #
\d ;

-- 8.1 商品 新增
\d #
create procedure pins(in newid int, newnumber varchar(100), newname varchar(100)
, newrprice varchar(100), newcompanyname varchar(100))
begin
    insert into products (pID,pNumber,pName,pRPrice,pcompanyname) 
    values (newid,newnumber,newname,newrprice,newcompanyname);
end #
\d ;
-- 8.2 商品 刪除
\d #
create procedure pdel (in kw int)
begin
    delete from products where pID = kw; -- 指定ID刪除
end #
\d ;
-- 8.3 商品 修改
\d #
create procedure pupd(in kw int,newnumber varchar(100), newname varchar(100)
, newrprice varchar(100), newcompanyname varchar(100))
begin
    update products
    set 
    pNumber = newnumber,
    pName = newname,
    pRPrice = newrprice,
    pcompanyname = newcompanyname -- 外鍵
    where pID = kw; -- 指定ID新增
end #
\d ;
-- 8.4 查詢 商品 名稱
\d #
create procedure pinname (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    if (select count(*) from products where pName like @key) = 0 then
    	SELECT * FROM products;
    else 
    	select * from products where pName like @key;
    end if;
end #
\d ;

-- 9.1 訂單 新增
\d #
create procedure oins(in newid int, newnumber varchar(100), newcustomer varchar(100))
begin
    insert into Orders (oID, oNumber, oCustomer) 
    values (newid,newnumber,newcustomer);
end #
\d ;
-- 9.2 訂單 刪除
\d #
create procedure odel (in kw int)
begin
    delete from orders where oID = kw; -- 指定ID刪除
end #
\d ;
-- 9.3 訂單細項的處理 a.訂單詳細跟著訂單增加變動
 \d #
 create trigger addod after insert on orders for each row
 begin
     insert into odetails (odNumber) values (new.oNumber); -- 跟著訂單新增對應訂單細項
 end #
 \d ;
 -- 9.3 訂單細項的處理 b.訂單詳細跟著訂單刪除變動
 \d #
 create trigger delod before delete on orders for each row
 begin
	delete from odetails where odNumber = (old.onumber); -- 再刪除訂單前先刪除對應訂單細項
 end #
 \d ;

-- 10.1 訂單明細 新增
\d #
create procedure odins(in newid int, newnumber varchar(100), newproduct varchar(100)
, newaprice varchar(100), newquantity varchar(100))
begin
    insert into odetails(odid,odNumber,odproduct,odAPrice,odQuantity) 
    values (newid,newnumber,newproduct,newaprice,newquantity);
end #
\d ;
-- 10.2 訂單明細 刪除
\d #
create procedure oddel (in kw int)
begin
    delete from odetails where odID = kw; -- 指定ID刪除
end #
\d ;
-- 10.3 訂單明細 修改
\d #
create procedure odupd(in kw int,newaprice varchar(100), newquantity varchar(100))
begin
    update odetails
    set 
    odAPrice = newaprice,
    odQuantity = newquantity
    where odID = kw; -- 指定ID新增
end #
\d ;

-- 11.a 指定客戶查詢訂單,含訂單明細
\d #
create procedure QCO (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    select  customers.cName, orders.oNumber, products.pName, odetails.odAPrice, odetails.odQuantity from customers
            join orders on (orders.oCustomer = customers.cPhone)
            join odetails on (odetails.odNumber = orders.oNumber) 
            join products on (odetails.odproduct = products.pNumber)
            where customers.cname like @key; -- 表格join 再關鍵字查詢
end #
\d ;
-- 11.b 指定客戶查詢訂單總金額
\d #
create procedure QTC (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    select  customers.cName Name, sum(odetails.odAPrice*odetails.odQuantity) total from orders
            join odetails on (odetails.odNumber = orders.oNumber)
            join customers on (orders.oCustomer = customers.cPhone)
            where customers.cname like @key
            group by customers.cname; -- 群組客戶名稱
end #
\d ;
-- 11.c 指定商品查詢訂單中的客戶, 例如: 商品P001的客戶有哪些,買幾個
\d #
create procedure QNC (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    select  products.pName, customers.cname, odetails.odQuantity from odetails
            join orders on (odetails.odNumber = orders.oNumber)
            join customers on (orders.oCustomer = customers.cphone)
            join products on (odetails.odproduct = products.pNumber)
            where products.pname like @key;
end #
\d ;
-- 11.d 指定供應商查詢訂單中的商品清單
\d #
create procedure QSL (in kw varchar(100))
begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    select  suppliers.sName, orders.oNumber, products.pname, odetails.odQuantity from odetails
            join orders on (odetails.odNumber = orders.oNumber)
            join products on (odetails.odproduct = products.pNumber)
            join suppliers on (products.pcompanyname = suppliers.sphone)
            where suppliers.sname like @key;
end #
\d ;