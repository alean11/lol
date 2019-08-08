---------- *** Final DB *** -------------
/* DB 작성할 때 '날짜.이름.작성내용' 적을 것*/

show user;

select *
from acc_tbl join room_tbl 
on acc_idx = fk_acc_idx
where acc_idx = 21 ;

select cp_id, acc_name, acc_grade, acc_type, acc_tel1 || acc_tel2 || acc_tel3 as tel, acc_addr1, acc_addr2, acc_img, acc_text
from acc_tbl;
update personal_mbr set p_pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
where p_userid = 'admin';
commit;
rollback;
select *
from personal_mbr
where p_name = '김명진' and p_hp1 || p_hp2 || p_hp3 = '01077030068';
select *
from acc_tbl
order by acc_name;
commit;
update acc_tbl set acc_img =  '정선_메이힐스_리조트_HI508881076.jpg'
where acc_idx = 58;
select * 
from room_tbl;

select *
from personal_mbr
where p_name = '김명진' and p_hp1 || p_hp2 || p_hp3 = '01077030068';

select *
from barmenity;
where cp_id = 'gunhee4';


--------일반회원테이블  : personal_mbr ------------------
create table personal_mbr
    (idx number not null
    ,p_userid varchar2(20)  not null
    ,p_pwd varchar2(300)    not null
    ,p_name varchar2(40)    not null
    ,p_email varchar2(300)  not null
    ,p_birthday varchar2(8) 
    ,p_gender number(1)     not null
    ,p_hp1 varchar2(3)      not null
    ,p_hp2 varchar2(100)    not null
    ,p_hp3 varchar2(100)    not null
    ,p_post1 varchar2(30)   not null
    ,p_post2 varchar2(30)   not null
    ,p_addr1 varchar2(90)   not null
    ,p_addr2 varchar2(90)   not null
    ,p_registerday date default sysdate
    ,p_lastlogin date
    ,p_lastpwdchg date default sysdate
    ,p_status number(1) default 1
,constraint PK_personal_mbr primary key(p_userid)
,constraint CK_personal_mbr_gender check(p_gender in(1,2))
);


--------일반회원 시퀀스
create sequence seq_personal_mbr
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;




-----------------------------------------------------------------------------
--------좋아요 테이블 : like_tbl
create table like_tbl
(acc_idx number
,p_userid varchar2(20)  not null
,status number(1) DEFAULT 0
,constraint FK_like_tbl_p_userid FOREIGN key(p_userid) references personal_mbr(p_userid)
,constraint FK_like_tbl_acc_idx FOREIGN key(acc_idx) references acc_tbl(acc_idx)
);



-------------------------------------------------------------------------------
--------댓글테이블 :comment_tbl
create table comment_tbl
(acc_idx number not null
,p_userid varchar2(20)  not null
,comments CLOB
,status number(1) DEFAULT 1
,com_writedate date default sysdate
,constraint FK_comment_tbl_p_userid FOREIGN key(p_userid) references personal_mbr(p_userid)
,constraint FK_comment_tbl_acc_idx FOREIGN key(acc_idx) references acc_tbl(acc_idx)
);




--------------------------------------------------------
--------QNA 테이블 : qna_tbl
create table qna_tbl
(qna_idx number         not null
,p_userid varchar2(20)
,q_title varchar2(40)   not null
,q_context CLOB         not null
,q_writeday date default sysdate
,q_writer varchar2(40)  not null
,q_viewcnt number(6)    not null
,q_pwd number(4)        not null
,status number(1)   default 1
,constraint FK_qna_tbl_p_userid FOREIGN key(p_userid) references personal_mbr(p_userid)
);

--------QNA 시퀀스
create sequence seq_qna_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



-----------------------------------------------
----------공지사항테이블----------------------
create table notice
(n_idx number
,n_title varchar2(20)   not null
,n_context CLOB         not null
,n_writeday date   DEFAULT sysdate
,n_viewcnt number(6)    not null
,status number(1)   DEFAULT 1
,constraint PK_notice_idx primary key(n_idx)
);

--------공지사항 시퀀스
create sequence seq_notice
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



-------------------------------------------------
----기업회원테이블  :  company_mbr
create table company_mbr
(idx number
,cp_id varchar2(20) 
,cp_pwd varchar2(300)   not null
,cp_num1 varchar2(3)    not null
,cp_num2 varchar2(2)    not null
,cp_num3 varchar2(5)    not null
,cp_name varchar2(60)   not null
,ceoname varchar2(40)   not null
,cp_email varchar2(300) not null
,cp_tel1 varchar2(3)    not null
,cp_tel2 varchar2(4)    not null
,cp_tel3 varchar2(4)    not null
,status number(1) DEFAULT 1
,constraint PK_company_mbr_cp_id primary key(cp_id)
);

--------기업회원 테이블 시퀀스
create sequence seq_company_mbr
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



--------------------------------------------------------
----업체 회원테이블  :  acc_tbl
create table acc_tbl
(acc_idx    number
,cp_id      varchar2(20)        not null
,state      number(2)           not null
,acc_name   varchar2(60)        not null
,acc_tel1   varchar2(3)         not null
,acc_tel2   varchar2(4)         not null
,acc_tel3   varchar2(4)         not null
,acc_post1  varchar2(3)         not null
,acc_post2  varchar2(3)         not null
,acc_addr1  varchar2(90)        not null
,acc_addr2  varchar2(90)        not null
,acc_img    varchar2(100)       not null
,acc_text   varchar2(4000)      not null    -- 2019.07.24. 정혜윤: 원래 CLOB였는데, 테이블 조인하면서 distinct가 안 먹어서 varchar2로 바꿈.
,acc_Rcnt   number(3)           not null
,acc_status number(1) DEFAULT 1
,acc_type   varchar2(10)        not null    -- 호텔/리조트    
,acc_grade  number(1)           not null      -- 1,2,3,4,5
,constraint PK_acc_tbl_acc_idx primary key(acc_idx)
,constraint FK_comment_tbl_cp_id FOREIGN key(cp_id) references company_mbr(cp_id)
,constraint FK_comment_tbl_state FOREIGN key(state) references area_tbl(region_code)
);
-- 2019.07.22. 정혜윤: 제약조건 이름 변경함. (기존에 회사 테이블 이름이 들어가 있어서, 업체 테이블 이름으로 바꿔줌.)
-- ALTER TABLE acc_tbl RENAME CONSTRAINT PK_company_mbr_acc_idx TO PK_acc_tbl_acc_idx;



    
--------업체 시퀀스
create sequence seq_acc_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;




------------------------------------------------
---------객실테이블 : room_tbl
create table room_tbl
(r_idx          number                            -- 방 고유번호. PK.
,FK_acc_idx     number           not null    -- 업체 테이블의 고유번호. 업체 테이블의 acc_idx를 참조하고 있음.
,FK_rtype_idx   varchar2(40)               -- 방 종류 고유번호. 방 종류 테이블의 rtype_idx를 참조하고 있음.
,r_text         varchar2(4000)   not null    -- 2019.07.24. 정혜윤: 원래 CLOB였는데, 테이블 조인하면서 distinct가 안 먹어서 varchar2로 바꿈.
,ay_fee         number(8)        not null
,k_fee          number(8)        not null
,constraint PK_room_tbl_r_idx primary key(r_idx)
,constraint FK_acc_tbl_acc_idx foreign key(acc_idx) references acc_tbl(acc_idx)
);
-- 2019.07.22. 정혜윤 추가: 방 종류 테이블 추가하면서, 객실 테이블도 이하와 같이 수정
-- ALTER TABLE room_tbl DROP (r_cnt);
-- ALTER TABLE room_tbl DROP COLUMN r_kind;
-- ALTER TABLE room_tbl ADD(FK_rtype_idx number);
-- ALTER TABLE room_tbl ADD CONSTRAINT FK_room_tbl_acc_idx FOREIGN KEY(FK_acc_idx) REFERENCES acc_tbl(acc_idx);
-- ALTER TABLE room_tbl ADD CONSTRAINT FK_room_tbl_rtype_idx FOREIGN KEY(FK_rtype_idx) REFERENCES room_type_tbl(rtype_idx);
SELECT *
FROM user_constraints
WHERE table_name = 'ROOM_TBL';

--------객실테이블 시퀀스
create sequence seq_room_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;


--------- 2109. 07. 22. 정혜윤 방 종류 테이블 생성
---- 방 종류 테이블: room_kind_tbl
create table room_type_tbl
(rtype_idx    number             -- 방 종류 고유 코드번호
,FK_acc_idx  number not null    -- 호텔(업체) 고유 번호(참조함.)
,rtype_Name  varchar2(60)       -- 방 종류 이름
,rtype_cnt   number(3)          -- 방 종류 개수
,constraint PK_room_type_tbl_room_idx primary key(room_idx)
,constraint FK_room_type_tbl_FK_acc_idx foreign key(FK_acc_idx) references acc_tbl(acc_idx)
);
-- 방 종류 테이블 시퀀스
create sequence seq_room_type_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;


------------------------------------------------------------------
-----장바구니 테이블 :cart_tbl
create table cart_tbl
(cartno number
,p_userid varchar2(20)  not null
,p_name     varchar2(40) not null
,r_idx number(4)    not null
,cart_price varchar2(7)     not null
,cart_cnt number(5)     not null
,startDate  varchar2(20)     not null
,endDate    varchar2(20)     not null
,constraint PK_cart_tbl_cartno primary key(cartno)
,constraint FK_room_tbl_r_idx foreign key(r_idx) references room_tbl(r_idx)
,constraint FK_personal_mbr_p_userid foreign key(p_userid) references personal_mbr(p_userid)
);

--------장바구니 시퀀스
create sequence seq_cart_tbl
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;


---------------------------------------------------------------
-- 예약여부확인 테이블 : booking_ck
create table booking_ck
(r_idx number       not null
,book_start date    not null
,book_end date      not null
,constraint FK_booking_ck_r_idx foreign key(r_idx) references room_tbl(r_idx)
);



-----------------------------------------------
-- 브라메니티 테이블  : barmenity
create table barmenity
(r_idx number   not null
,bm_br_addfee varchar2(6)     DEFAULT 'none'
,bm_amenity varchar2(300)   DEFAULT 'none'
,bm_device varchar2(300)    DEFAULT 'none'2
,constraint FK_barmenity_r_idx foreign key(r_idx) references room_tbl(r_idx)
);
select *
from cart_tbl
where p_userid = 'admin'
order by cartno asc;
commit;
select *
from acc_tbl;
update cart_tbl set fk_acc_name = '힐튼경주';
select c.cartno, p_userid, p_name, r_idx, cart_price, cart_cnt, fk_acc_name, fk_rtype_name, full_acc_addr, full_acc_tel, reserver, adultNum, kidsNum, contactinfo, payMethod, requesttxt, to_char(book_start, 'yyyy-mm-dd') as book_start, to_char(book_end, 'yyyy-mm-dd') as book_end, expectedtime, a.acc_grade, a.acc_img
		from acc_tbl a left join cart_tbl c
		on a.acc_name = c.fk_acc_name
		where p_userid = 'admin';
select c.cartno, p_userid, p_name, r_idx, cart_price, cart_cnt, fk_acc_name, fk_rtype_name, full_acc_addr, full_acc_tel, reserver, adultNum, kidsNum, contactinfo, payMethod, requesttxt, to_char(book_start, 'yyyy-mm-dd') as book_start, to_char(book_end, 'yyyy-mm-dd') as book_end, expectedtime, a.acc_grade, a.acc_img
		from acc_tbl a left join cart_tbl c

---------------------------------------------
-- 추가이미지 테이블 : addtional_img
create table addtional_img
(acc_idx number   not null  -- 2019.07.22. 정혜윤 수정: 기존에 room_tbl 참조하던 것을 acc_tbl 참조하던 것으로 바꾸면서, 컬럼도 수정함.
,ad_img1 varchar2(100)
,ad_img2 varchar2(100)
,ad_img3 varchar2(100)
,ad_img4 varchar2(100)
,ad_img5 varchar2(100)
,constraint FK_addtional_img_acc_idx foreign key(acc_idx) references acc_tbl(acc_idx) -- 2019.07.22. 정혜윤 수정: 기존에 room_tbl 참조하던 것을 acc_tbl 참조하던 것으로 바꿈.
);



---------------------------------------
-- 태그테이블
create table acc_tag
(acc_idx		number  not null
,acc_name	varchar2(60)    not null
,cnt		number          DEFAULT 0
,constraint FK_acc_tag_acc_idx foreign key(acc_idx) references acc_tbl(acc_idx)
);





--------------------------------------------
-- 지역 테이블
create table area_tbl
(
region_code number(2)   not null
,region_name varchar2(20)   not null
,region_shortName varchar2(10) not null    
,constraint PK_area_tbl_region_code primary key(region_code)
);
commit;


-------------- 2019.07.17. 정혜윤: 지역코드 추가
/* 지역코드
서울: 1
경기: 2
강원: 3
충북: 4
충남: 5
경북: 6
경남: 7
전북: 8
전남: 9
제주: 10
*/
insert into area_tbl(region_code, region_name, region_shortName)
values(1, '서울', '서울');
insert into area_tbl(region_code, region_name, region_shortName)
values(2, '경기도', '경기');
insert into area_tbl(region_code, region_name, region_shortName)
values(3, '강원도', '강원');
insert into area_tbl(region_code, region_name, region_shortName)
values(4, '충청북도', '충북');
insert into area_tbl(region_code, region_name, region_shortName)
values(5, '충청남도', '충남');
insert into area_tbl(region_code, region_name, region_shortName)
values(6, '경상북도', '경북');
insert into area_tbl(region_code, region_name, region_shortName)
values(7, '경상남도', '경남');
insert into area_tbl(region_code, region_name, region_shortName)
values(8, '전라북도', '전북');
insert into area_tbl(region_code, region_name, region_shortName)
values(9, '전라남도', '전남');
insert into area_tbl(region_code, region_name, region_shortName)
values(10, '제주도', '제주');

commit;






----------------------------------****************** 인라인뷰 시작 *****************************---------------------------------------------

-- 2019.07.24. 정혜윤
-- 최종적으로 만든 인라인뷰(상세페이지, 상세검색 등에 사용 가능.)
-- 합친 테이블: acc_tbl, area_tbl, acc_tag, room_tbl, room_type_tbl, booking_ck


-- !!!!!!! 사용할 때는 맨 위 select 문에 필요한 컬럼 써서 사용할 것 !!!!!!!
select distinct ACC_IDX, ACC_NAME, ACC_IMG, ACC_TEXT, REGION_NAME, ACC_ADDR1, CNT
--     , (ay_fee * 1) + (k_fee * 0) AS TOTALPAY
from view_hotel_list_search
WHERE (acc_addr1 like '%'|| '경상북도' || '%'or acc_addr1  like '%'|| '경상남도' || '%') 
  and (ay_fee * 1) + (k_fee * 0) between 0 and 249000
  and book_start NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')
  and book_end NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')
order by ACC_IDX;



-- 인라인뷰로 만들 때 썼던 쿼리문
CREATE OR REPLACE VIEW view_hotel_list_search
AS
SELECT acc_idx, cp_id, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2
     , acc_img, acc_rcnt, acc_status, acc_type, acc_grade, acc_text, region_name, region_shortname, cnt
     , ay_fee, k_fee, book_start, book_end 
FROM
   (
    SELECT D.acc_idx, D.cp_id, D.acc_name, D.acc_tel1, D.acc_tel2, D.acc_tel3, D.acc_post1, D.acc_post2, D.acc_addr1, D.acc_addr2
         , D.acc_img, D.acc_rcnt, D.acc_status, D.acc_type, D.acc_grade, D.acc_text, D.region_name, D.region_shortname, D.cnt
         , G.ay_fee, G.k_fee, G.book_start, G.book_end
    FROM
       (
       -----------------------------------------------------
         select A.acc_idx, A.CP_ID, A.acc_name, A.acc_tel1, A.acc_tel2, A.acc_tel3, A.acc_post1, A.acc_post2, A.acc_addr1, A.acc_addr2
              , A.acc_img, A.acc_rcnt, A.acc_status, A.acc_type, A.acc_grade, A.acc_text
              , B.region_name, B.region_shortname
              , nvl(C.cnt, 0) AS cnt
         from acc_tbl A LEFT JOIN area_tbl B
         ON A.state = B.region_code
         LEFT JOIN acc_tag C
         ON A.acc_idx = C.acc_idx            
         ----------------------------------
       ) D
    LEFT OUTER JOIN
       ( select E.r_idx, E.fk_acc_idx, E.ay_fee, E.k_fee, E.r_text
              , F.book_start, F.book_end
         from room_tbl E LEFT OUTER JOIN booking_ck F
         on E.r_idx = F.r_idx
        ) G
    ON D.acc_idx = G.fk_acc_idx
   ) G;
------------------------------------------
----------------------------------************************ 인라인뷰 끝 ***********************---------------------------------------------



-- 2019.07.25. 정혜윤 추가
-- 상세검색 리스트 페이지 호텔 뽑는 쿼리문: 검색어 및 페이징 처리
-- 현재 방 가격 같은 값이 다 들어간 상태가 아니라서, 값 없어서 뜨지 않는 호텔들이 있음.
select acc_idx, acc_name, acc_img, acc_text, acc_addr1, acc_addr2, cnt, acc_type, region_name
from
    (
     select rownum AS RNO, acc_idx, acc_name, acc_img, acc_text, acc_addr1, acc_addr2, cnt, acc_type
          , region_name, region_shortname
     from
         ( 
          select distinct acc_idx, acc_name, acc_img, acc_text, acc_addr1, acc_addr2, cnt, acc_type
               , region_name, region_shortname
          from
              (
               select acc_idx, acc_name, acc_img, acc_text, acc_addr1, acc_addr2, cnt, acc_type
                    , region_name, region_shortname, acc_grade
               from view_hotel_list_search
               where 1 = 1
               and ((ay_fee * 1) + (k_fee * 1) between 0 and 99999999) -- 가격옵션. null 가능성 있음.
               and (acc_addr1 like '%'|| '경상' || '%' or acc_addr2 like '%'|| '경상' || '%' or
                    acc_addr1 like '%'|| '백령도' || '%' or acc_addr2 like '%'|| '백령도' || '%') -- 지역날씨에서 얻은 지역. null 가능성 있음.
               and (book_start NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')) -- null 가능성 있음.
               and (book_end NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')) -- null 가능성 있음.
               and (acc_grade = 4)
               and (acc_type like '%'|| '리조트' || '%')
              ) V
          where acc_addr1 like '%'|| '아난티' || '%' or acc_name like '%'|| '아난티' || '%' or region_shortname like '%' || '아난티' || '%' -- 검색어에서 얻은 지역. null 가능성 있음.
         ) T
    ) F
where RNO between 1 and 10


select * from view_hotel_list_search



-- 호텔 등급별 개수 뽑는 쿼리문: 검색조건 포함임.
select acc_type, count(*)
from
    (
     select acc_name, acc_addr1, acc_addr2, acc_type, acc_grade
          , region_name, region_shortname
     from view_hotel_list_search
     where 1 = 1
       and ((ay_fee * 1) + (k_fee * 1) between 0 and 99999999) -- 가격옵션. null 가능성 있음.
       and (acc_addr1 like '%'|| '경상' || '%' or acc_addr2 like '%'|| '경상' || '%' or
            acc_addr1 like '%'|| '백령도' || '%' or acc_addr2 like '%'|| '백령도' || '%') -- 지역날씨에서 얻은 지역. null 가능성 있음.
       and (book_start NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')) -- null 가능성 있음.
       and (book_end NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')) -- null 가능성 있음.
       and (acc_grade = 4)
       and (acc_type like '%'|| '리조트' || '%')
    ) V
--where acc_addr1 like '%'|| '서울' || '%' or acc_name like '%'|| '서울' || '%' or region_shortname like '%' || '서울' || '%' -- 검색어에서 얻은 지역. null 가능성 있음.
group by acc_type;



--------------------------****************************** 연습 *********************************-----------------------------------------
/*
-- 2019.07.21 정혜윤 추가: 호텔 리스트 뽑는 쿼리문(검색어 포함) <- 수정해서 만든 결과가 view_hotel_list_search 이므로, 이하는 주석문 처리함.

-- 쿼리문
--     : acc_tbl, area_tbl, acc_tag, room_tbl, room_type_tbl, booking_ck 합친 것
    SELECT distinct acc_idx, acc_name, acc_img, acc_text, region_name, acc_addr1, acc_type, cnt
      , ay_fee, k_fee, book_start, book_end 
         , (ay_fee * 4) + (k_fee * 4) AS TOTALPAY -- 앨리어스는 인덱스로 만들 수 없는데, 인덱스로 만들어진 애들을 데리고 계산하니까, 안 느려지겠지..? (질문하기)
    FROM
       (
        SELECT E.acc_idx, E.acc_name, E.acc_img, E.acc_text, E.region_name, E.acc_addr1, E.cnt, E.acc_type
             , F.ay_fee, F.k_fee, F.book_start, F.book_end
        FROM
           (
             SELECT C.acc_idx, C.acc_name, C.acc_img, C.acc_text, C.acc_type, C.acc_addr1, C.region_name
                  , cnt
             FROM
                ( select acc_idx, acc_name, acc_img, acc_text, acc_addr1, acc_type, region_name
                  from acc_tbl A LEFT OUTER JOIN area_tbl B
                  ON A.state = B.region_code
                ) C
             LEFT OUTER JOIN
                ( select acc_idx, acc_name, cnt
                       , rtype_idx, fk_acc_idx, rtype_name, rtype_cnt
                  from
                      (
                      select acc_idx, acc_name, cnt
                      from acc_tag
                      ) I
                  RIGHT OUTER JOIN  room_type_tbl J
                  ON I.acc_idx = J.FK_ACC_IDX
                ) D
             ON C.acc_idx = D.acc_idx
           ) E
        LEFT OUTER JOIN
           ( select ay_fee, k_fee, fk_acc_idx, book_start, book_end
             from room_tbl G LEFT OUTER JOIN booking_ck H
             on G.r_idx = H.r_idx
            ) F
        ON E.acc_idx = F.fk_acc_idx
       ) G
    WHERE (acc_addr1 like '%'|| '경상북도' || '%' or acc_addr1  like '%'|| '경상남도' || '%') 
          and (ay_fee * 1) + (k_fee * 0) between 0 and 99999999
          and book_start NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')
          and book_end NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')
    ORDER BY RNO asc;
*/

/*

-- 컬럼 기준 카운트 개수 실험
select COUNT(*) OVER (PARTITION BY cp_id)
from acc_tbl;

-- 요금 계산할 때 쿼리문
select r_idx, fk_acc_idx, r_text, ay_fee,  k_fee,  fk_rtype_idx,
      (ay_fee * 4) + (k_fee * 4) AS TOTALPAY
from room_tbl
where (ay_fee * 4) + (k_fee * 4) between 725845 and 2495784
   -- (ay_fee*인원수)+(k_fee*인원수) between 검색한 값1 and 검색한 값2


-- 조인 실험
select commentCnt, acc_idx
     , rtype_idx, fk_acc_idx, rtype_name, rtype_cnt
from
    (
    select COUNT(*) OVER (PARTITION BY acc_idx) AS commentCnt, acc_idx
    from comment_tbl
    where status = 1
    ) A
RIGHT OUTER JOIN  room_type_tbl B
ON A.acc_idx = B.FK_ACC_IDX
order by rtype_idx;


select acc_name, acc_addr1, acc_idx
     , rtype_idx, rtype_name
     , r_idx, r_text, ay_fee, k_fee
from
    ( select acc_name, acc_addr1, acc_idx
           , FK_acc_idx, rtype_idx, rtype_name, rtype_cnt
      from acc_tbl A LEFT OUTER JOIN room_type_tbl B
      ON A.acc_idx = B.FK_acc_idx
    ) C
    LEFT OUTER JOIN
    ( select r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee
      from room_tbl
    ) D
ON C.rtype_idx = D.r_idx
order by rtype_idx;
*/



    
 ----------- 2019.07.24. 서영학: 강사님이 시험삼아 만드신 것 -----------------------------------------------------------------------------------------------------
 -- 원본
 SELECT acc_idx, acc_name, acc_img, acc_text, region_name, acc_addr1, acc_type, cnt
      , ay_fee, k_fee, book_start, book_end 
         , (ay_fee * 4) + (k_fee * 4) AS TOTALPAY -- 앨리어스는 인덱스로 만들 수 없는데, 인덱스로 만들어진 애들을 데리고 계산하니까, 안 느려지겠지..? (질문하기)
    FROM
       (
        SELECT E.acc_idx, E.acc_addr1, E.acc_img, E.acc_type, E.acc_text, E.region_name, E.region_shortname, E.cnt
             , F.ay_fee, F.k_fee, F.book_start, F.book_end
        FROM
           (
             -----------------------------------------------------
             -- 원본에 1차 정리를 갖다 붙임
             select A.acc_idx,A.acc_name,A.acc_addr1, A.acc_img, A.acc_type, A.acc_text
                  , B.region_name, B.region_shortname
                  , nvl(C.cnt, 0) AS cnt
             from acc_tbl A LEFT JOIN area_tbl B
             ON A.state = B.region_code
             LEFT JOIN acc_tag C
             ON A.acc_idx = C.acc_idx      
             ----------------------------------
           ) E
           
        LEFT OUTER JOIN
           ( select ay_fee, k_fee, fk_acc_idx, book_start, book_end
             from room_tbl G LEFT OUTER JOIN booking_ck H
             on G.r_idx = H.r_idx
            ) F
        ON E.acc_idx = F.fk_acc_idx
       ) G;
-- end of 원본 ----------------------------------------------------------------------------------------------
 
 

-- ********************************************************************************************************** -- 
-- 2차 정리
SELECT E.acc_idx, E.acc_name, E.acc_img, E.acc_text, E.region_name, E.acc_addr1, E.cnt, E.acc_type
     , F.ay_fee, F.k_fee, F.book_start, F.book_end
FROM
   (
     -----------------------------------------------------
     -- 1차 정리
     select A.acc_idx, A.acc_name, acc_img, acc_text, acc_addr1, acc_type, region_name, nvl(cnt, 0) AS cnt
     from acc_tbl A LEFT JOIN area_tbl B
     ON A.state = B.region_code
     LEFT JOIN acc_tag C
     ON A.acc_idx = C.acc_idx            
     -- end of 1차 정리 -----------------------------------
   ) E
LEFT OUTER JOIN
   ( select ay_fee, k_fee, fk_acc_idx, book_start, book_end
     from room_tbl G LEFT OUTER JOIN booking_ck H
     on G.r_idx = H.r_idx
    ) F
ON E.acc_idx = F.fk_acc_idx;
-- end of 2차 정리
-- ********************************************************************************************************** -- 



-- 3차 정리 & 인라인뷰로 만들기
create or replace view view_abcd
as
SELECT E.acc_idx, E.acc_name, E.acc_img, E.acc_text, E.region_name, E.acc_addr1, E.cnt, E.acc_type
     , F.ay_fee, F.k_fee, F.book_start, F.book_end
FROM
   (
     select A.acc_idx, A.acc_name, acc_img, acc_text, acc_addr1, acc_type, region_name, nvl(cnt, 0) AS cnt
     from acc_tbl A LEFT JOIN area_tbl B
     ON A.state = B.region_code
     LEFT JOIN acc_tag C
     ON A.acc_idx = C.acc_idx            
   ) E
LEFT OUTER JOIN
   ( select ay_fee, k_fee, fk_acc_idx, book_start, book_end
     from room_tbl G LEFT OUTER JOIN booking_ck H
     on G.r_idx = H.r_idx
    ) F
ON E.acc_idx = F.fk_acc_idx;

select *
from view_abcd;

-- end of 3차 정리
-- ********************************************************************************************************** -- 




-- 4차 정리
--  : distinct 먹게 하려고, 조인해서 쓴 테이블 중 clob 타입인 것들을 varchar2(4000)으로 바꿈.

desc room_tbl;  

alter table room_tbl
modify(R_TEXT varchar2(4000));

select *
from room_tbl;

create table imsi_room_tbl
as
select *
from room_tbl;

select *
from imsi_room_tbl;

alter table room_tbl
drop column r_text;

alter table room_tbl
add r_text varchar2(4000);

update room_tbl A set r_text = (select r_text from imsi_room_tbl where r_idx = A.r_idx);  

commit;

desc acc_tbl;

create table imsi_acc_tbl
as
select *
from acc_tbl;

alter table acc_tbl
drop column acc_text;

alter table acc_tbl
add acc_text varchar2(4000);

update acc_tbl A set acc_text = (select acc_text from imsi_acc_tbl where acc_idx = A.acc_idx);  

commit;

select *
from acc_tbl;

-- end of 4차 정리
-- ********************************************************************************************************** -- 




-- 5차 정리
-- 결과: distinct 이용해서 중복된 행 없애면서 select 하기
select distinct ACC_IDX, ACC_NAME, ACC_IMG, ACC_TEXT, REGION_NAME, ACC_ADDR1, CNT
from view_abcd
--WHERE (acc_addr1 like '%'|| '경상북도' || '%' or acc_addr1  like '%'|| '경상남도' || '%') 
--          and (ay_fee * 1) + (k_fee * 0) between 0 and 99999999
--          and book_start NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')
--          and book_end NOT between TO_DATE('2019-07-01','YYYY-MM-DD HH24:MI:SS') and TO_DATE('2019-07-02', 'YYYY-MM-DD HH24:MI:SS')
order by  ACC_IDX;
          
drop view view_abcd;
commit;

-- end of 5차 정리
-- ********************************************************************************************************** --






 
 

select *
from comment_tbl;

delete from comment_tbl
where com_writedate = '19/07/24';
rollback;
-------------- 2019.07.24. 정혜윤
-- : 댓글 테이블에 댓글 몇 개 추가
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(16, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(16, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(17, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(17, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(17, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(18, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(18, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(18, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(18, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(18, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(22, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(22, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(22, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(22, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(7, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(8, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(8, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(9, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(9, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(10, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);
insert into comment_tbl(acc_idx, p_userid, comments, status, com_writedate)
values(13, 'admin', '우오오아ㅗ아와앙ㅇ', default, default);

-- :태그 테이블에 몇 개 인서트
insert into acc_tag(acc_idx, acc_name, cnt)
values(16, '켄싱턴 리조트 경주', 5);
insert into acc_tag(acc_idx, acc_name, cnt)
values(17, '힐튼경주', 39);
insert into acc_tag(acc_idx, acc_name, cnt)
values(18, '베니키아 스위스로젠 호텔', 12);
insert into acc_tag(acc_idx, acc_name, cnt)
values(22, '경주 코오롱 호텔', 3);
insert into acc_tag(acc_idx, acc_name, cnt)
values(23, '마우나 오션 리조트', 55);
insert into acc_tag(acc_idx, acc_name, cnt)
values(7, '스탠포드 호텔 리조트 통영', 89);
insert into acc_tag(acc_idx, acc_name, cnt)
values(8, '아난티 남해', 41);
insert into acc_tag(acc_idx, acc_name, cnt)
values(9, '아이스퀘어호텔', 11);








-------------- 2019.07.22. 정혜윤: 객실, 방종류, 예약 테이블 데이터 몇 개 추가

-- 객실 종류 추가
insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 7, '럭셔리룸', 10);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 7, '트윈룸', 18);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 8, '초호화룸', 5);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 8, '스위트룸', 10);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 9, '트윈베드룸', 24);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 9, '스위트룸', 11);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 10, '럭셔리룸', 8);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 11, '스위트룸', 5);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 13, '더블베드룸', 24);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 16, '초호화럭셔리', 7);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 17, '트윈 스위트', 8);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 18, '럭셔리', 3);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 18, '트윈베드', 15);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 22, '스위트룸', 16);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 22, '트윈베드룸', 22);

insert into room_type_tbl(rtype_idx, FK_acc_idx, rtype_Name, rtype_cnt)
values(seq_room_type_tbl.nextval, 23, 'vip룸', 3);



--------- 객실 추가
insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 7, 1, '완전 럭셔리', 330000, 180000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 7, 2, '트윈룸임', 200000, 100000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 8, 3, '이런 초호화룸은 존재하지 않는다..', 1000000, 800000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 8, 4, '스위트룸임', 249000, 139000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 9, 5, '트윈 베드룸임.', 118000, 89000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 9, 6, '스위트룸입니다..', 287000, 168000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 10, 7, '완전 럭셔리 할 것 같지? 아니야 돌아가~', 880080, 658000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 11, 8, '스윗해', 213000, 124000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 13, 9, '더블 베드룸. 한 침대는 힘든 사람 ㄱㄱ', 87000, 45000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 16, 10, '초초초초초초촟촟ㅊ초호화 럭셔리 룸', 789000, 542000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 17, 11, '힐튼을 맛보고 싶어? 트윈 스위트 루우우웅움ㄱㄱ', 335000, 187000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 18, 12, '응 럭셔리 아니야 돌아가', 123000, 69000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 18, 12, '여관이 뭔지 맛볼 수 있는 트윈베드룸', 87000, 45000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 22, 14, '스위트룸 같은데 스위트룸 아님', 139000, 780000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 22, 15, '겉은 럭셔리한 트윈베드룸', 169000, 87000);

insert into room_tbl(r_idx, FK_acc_idx, FK_rtype_idx, r_text, ay_fee, k_fee)
values(seq_room_tbl.nextval, 23, 16, 'vip만 모심', 489000, 279000);



-- 예약 테이블 insert
insert into booking_ck(r_idx, book_start, book_end)
values(1, to_date('2019-08-08 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-10 12:00:00','YYYY-MM-DD HH24:MI:SS'));

insert into booking_ck(r_idx, book_start, book_end)
values(2, to_date('2019-08-09 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-10 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(3, to_date('2019-08-12 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-15 13:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(4, to_date('2019-08-08 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-14 13:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(5, to_date('2019-08-07 11:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-09 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(6, to_date('2019-08-10 11:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-11 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(7, to_date('2019-08-06 12:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-08 10:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(9, to_date('2019-08-14 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-17 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(10, to_date('2019-08-14 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-15 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(11, to_date('2019-08-12 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-16 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(12, to_date('2019-08-14 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-18 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(13, to_date('2019-09-01 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-09-04 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(14, to_date('2019-08-17 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-19 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(15, to_date('2019-09-15 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-09-22 12:00:00','YYYY-MM-DD HH24:MI:SS'));


insert into booking_ck(r_idx, book_start, book_end)
values(16, to_date('2019-08-23 10:00:00','YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-30 12:00:00','YYYY-MM-DD HH24:MI:SS'));




-------------- 2019.07.17. 정혜윤: 호텔 추가 (경상남도)

------------------------------------ 회사 및 호텔 정보 입력 시작 --------------------------------------------
/* 호텔 여러 개 있는 기업종류

라마다(ramada), 대명(daemyong), 앰배서더(ambassador), 금호(kumho), 한화(hanhwa),
켄싱턴(kensington), 힐튼(hilton), 코오롱(kolong), 신라(shinla), 롯데(lotte), 하얏트(hyatt),
메리어트(marriott), 한진=칼(hanjin)

*/

/*
select ascii('&') from dual;
select chr(38) from dual;

select ascii('a') from dual;
select chr(97) from dual;

select  '스탠포드 호텔'||chr(38)||'리조트 통영' from  dual;
select replace('스탠포드 호텔}리조트 통영','}',chr(38)) from dual;
insert into aaa(memo)  values(replace('스탠포드 호텔}리조트 통영','}',chr(38)));
*/

----------- >>>>>>>>>>>>>> 경상남도 <<<<<<<<<<<<<<<< --------------------------

-- 스탠포드 호텔&리조트 통영
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'stanford', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '스탠포드', '스탠포드', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'stanford', 7, '스탠포드 호텔 리조트 통영', '055', '725', '0000', '530', '79', '경상남도 통영시 도남동 도남로 347', '스탠포드 호텔 리조트 통영', '리조트 통영_HI569533145.jpg', '호텔 설명', '120', default, '호텔', 5);



-- 라마다 스위츠 거제
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'ramada', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '라마다', '스위츠', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ramada', 7, '라마다 스위츠 거제', '000', '0000', '0000', '533', '26', '경상남도 거제시 일운면 거제대로 2631', '소동리 라마다호텔', '라마다 거제_HI533294890.jpg',  '호텔설명',  '80', default, '리조트', 5);



-- 아난티 남해
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'ananti', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '아난티', '아난티', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ananti',  7,  '아난티 남해',  '000',  '0000',  '0000',  '524',  '33', '경상남도 남해군 남면 남서대로1179번길 40-109', '아난티남해골프장', '아난티 남해_HI549544950.jpg',  '호텔설명',  '220', default, '리조트', 4);



-- 아이스퀘어호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'isquare', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '아이스퀘어', '스퀘어', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'isquare',  7,  '아이스퀘어호텔',  '000',  '0000',  '0000',  '509',  '40', '경상남도 김해시 김해대로 2360', '부원동 아이스퀘어', '아이스퀘어_HI409061760.jpg',  '호텔설명',  '70', default, '호텔', 4);



-- 대명리조트 거제마리나
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'daemyong', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '대명', '대명씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'daemyong',  7,  '대명리조트 거제마리나',  '000',  '0000',  '0000',  '533',  '26', '경상남도 거제시 일운면 거제대로 2660', '소동리 대명리조트거제휴양콘도미니엄', '대명리조트 거제마리나_HI543279018.jpg',  '호텔설명',  '230', default, '리조트', 4);



-- 그랜드 머큐어 앰배서더 창원
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'ambassador', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '앰배서더', '앰배씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ambassador',  7,  '그랜드 머큐어 앰배서더 창원',  '000',  '0000',  '0000',  '514',  '08', '경상남도 창원시 의창구 원이대로 332', '대원동 더시티세븐풀만호텔', '그랜드 머큐어 앰배서더_HI552205106.jpg',  '호텔설명',  '70', default, '호텔', 5);



-- 금호 통영 마리나 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'kumho', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '금호', '아시아나', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kumho',  7,  '금호 통영 마리나 리조트',  '000',  '0000',  '0000',  '530',  '79', '경상남도 통영시 큰발개1길 33', '도남동 금호충무마리나콘도', '금호 통영_HI519521852.jpg',  '호텔설명',  '82', default, '리조트', 3);



-- 아르떼리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'arte', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '아르떼', '아르씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'arte',  7,  '아르떼리조트',  '000',  '0000',  '0000',  '525',  '54', '경상남도 사천시 해안관광로 109-10', '실안동 아르떼리조트', '아르떼리조트_HI400835701.jpg',  '호텔설명',  '90', default, '호텔', 3);



-- 한화리조트 거제 벨버디어
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'hanhwa', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '한화', 'ceo이름', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hanhwa',  7,  '한화리조트 거제 벨버디어',  '000',  '0000',  '0000',  '532',  '00', '경상남도 거제시 장목면 거제북로 2501-40', '농소리 한화리조트거제벨버디어', '한화거제_HI549909636.jpg',  '호텔설명',  '110', default, '리조트', 5);



-- 프래밀리 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'frie', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '프래밀리', '프래씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'frie',  7,  '프래밀리 호텔',  '000',  '0000',  '0000',  '533',  '29', '경상남도 거제시 일운면 거제대로 2308', '와현리 프래밀리 호텔', '프래밀리_HI360877901.jpg',  '호텔설명',  '88', default, '호텔', 2);

commit;



-------------- 2019.07.18. 정혜윤: 호텔 추가
----------- >>>>>>>>>>>>>> 경상북도 <<<<<<<<<<<<<<<< --------------------------

-- 켄싱턴 리조트 경주
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'kensington', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '켄싱턴', '켄싱턴씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kensington',  6,  '켄싱턴 리조트 경주',  '000',  '0000',  '0000',  '381',  '16', '경상북도 경주시 보문로 182-29', '북군동 켄싱턴리조트', '켄싱턴경주_HI559613480.jpg',  '호텔설명',  '98', default, '리조트', 3);


-- 힐튼경주
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'hilton', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '힐튼', '힐튼씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hilton',  6,  '힐튼경주',  '000',  '0000',  '0000',  '381',  '17', '경상북도 경주시 보문로 484-7', '신평동 경주힐튼호텔/우양미술관', '힐튼경주_HI284113056.jpg',  '호텔설명', '78', default, '호텔', 5);


-- 베니키아 스위스로젠 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'bekinia', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '베키니아', '베키씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'bekinia',  6,  '베니키아 스위스로젠 호텔',  '000',  '0000',  '0000',  '381',  '16', '경상북도 경주시 보문로 465-37', '신평동 베니키아 스위스로젠 호텔', '베키니아스위스_HI332976473.jpg', '호텔설명', '65', default, '호텔', 2);


-- 호텔 금오산
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'kumosan', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '회사 이름', 'ceo이름', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kumosan',  6,  '호텔 금오산',  '000',  '0000',  '0000',  '393',  '09', '경상북도 구미시 금오산로 400', '남통동 금오산관광호텔', '금오산_HI341587514.jpg',  '호텔설명', '62', default, '호텔', 2);


-- 코모도 호텔 경주
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'komodo', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '코모도', '코모씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'komodo',  6,  '코모도 호텔 경주',  '000',  '0000',  '0000',  '381',  '17', '경상북도 경주시 보문로 422', '신평동 코모도호텔', '코모도경주_HI572849402.jpg',  '호텔설명', '79', default, '호텔', 1);


-- 더 케이 호텔 경주
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'thek', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '더케이', '케이씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'thek',  6,  '더 케이 호텔 경주',  '000',  '0000',  '0000',  '381',  '16', '경상북도 경주시 엑스포로 45', '신평동 더 케이 호텔 경주', '더케이_HI565821668.jpg',  '호텔설명', '88', default, '호텔', 4);


-- 경주 라마다호텔&리조트
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ramada',  6,  '경주 라마다호텔 리조트',  '000',  '0000',  '0000',  '381',  '23', '경상북도 경주시 감포읍 동해안로 1819-21', '나정리 경주 라마다호텔 리조트', '라마다 경주_HI548184513.jpg', '호텔설명', '111', default, '리조트', 3);


-- 경주 코오롱 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'kolong', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '코오롱', '코오씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kolong',  6,  '경주 코오롱 호텔',  '000',  '0000',  '0000', '381', '26', '경상북도 경주시 불국로 289-17', '마동 코오롱관광호텔', '경주 코오롱_HI505515773.jpg',  '호텔설명', '92', default, '호텔', 4);


-- 마우나 오션 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'mauna', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '마우나', '마우씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'mauna',  6,  '마우나 오션 리조트',  '000',  '0000',  '0000',  '382',  '21', '경상북도 경주시 양남면 동남로 982', '신대리 마우나오션리조트', '마우나리조트_HI569101615.jpg', '호텔설명', '65', default, '리조트', 1);




----------- >>>>>>>>>>>>>> 제주도 <<<<<<<<<<<<<<<< --------------------------

-- 제주 신라 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'shinla', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '신라', '이부진', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'shinla', 10,  '제주 신라 호텔',  '000',  '0000',  '0000',  '635',  '35', '제주특별자치도 서귀포시 중문관광로72번길 75', '색달동 신라호텔', '제주 신라_HI569101877.jpg', '호텔설명', '48', default, '호텔', 5);


-- 호텔 리젠트 마린 더 블루
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'resent', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '리젠트', '마린씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'resent',  10,  '호텔 리젠트 마린 더 블루',  '000',  '0000',  '0000',  '632',  '76', '제주특별자치도 제주시 서부두2길 20', '건입동 호텔리젠트마린더블루', '리젠트_HI557269113.jpg', '호텔설명', '54', default, '호텔', 3);


-- 골든튤립 제주성산호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'goldent', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '골든튤립', '골든튤립씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'goldent',  10,  '골든튤립 제주성산호텔',  '000',  '0000',  '0000',  '636',  '40', '제주특별자치도 서귀포시 성산읍 일출로 31', '고성리 골든튤립제주성산호텔', '골든튤립_HI389301768.jpg', '호텔설명', '51', default, '호텔', 1);


-- 롯데 시티 호텔 제주
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'lotte', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '롯데', '시게미츠', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'lotte',  10,  '롯데 시티 호텔 제주',  '000',  '0000',  '0000',  '631',  '27', '제주특별자치도 제주시 도령로 83', '연동 제주연동롯데시티호텔', '롯데 제주_HI505022007.jpg', '호텔설명', '67', default, '호텔', 5);


-- 라마다 제주 시티홀
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ramada',  10, '라마다 제주 시티홀', '000',  '0000', '0000', '632',  '22', '제주특별자치도 제주시 중앙로 304', '이도이동 라마다 제주 시티홀', '라마다 제주_HI384591626.jpg', '호텔설명', '55', default, '호텔', 1);


-- 하얏트 리젠시 제주
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'hyatt', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '하얏트', '하얏트씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hyatt',  10,  '하얏트 리젠시 제주',  '000',  '0000',  '0000',  '635',  '35', '제주특별자치도 서귀포시 중문관광로72번길 114', '색달동 하얏트호텔', '하얏트 제주_HI218879298.jpg',  '호텔설명',  '75', default, '호텔', 5);


-- 메리어트관 제주신화월드 호텔앤리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'marriott', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '메리어트', '메리엇씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'marriott',  10,  '메리어트관 제주신화월드 호텔앤리조트',  '000',  '0000',  '0000',  '635',  '22', '제주특별자치도 서귀포시 안덕면 신화역사로304번길 38', '서광리 메리어트관 제주신화월드 호텔앤리조트', '메리어트 제주_HI545070409.jpg',  '호텔설명',  '125', default, '리조트', 5);


-- 제주 칼 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'hanjin', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '한진', '조양호', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hanjin',  10,  '제주 칼 호텔',  '000',  '0000',  '0000',  '631',  '94', '제주특별자치도 제주시 중앙로 151', '이도일동 제주KAL호텔', '칼 제주_HI512987224.jpg',  '호텔설명',  '67', default, '호텔', 5);


-- 켄싱턴 호텔 제주
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kensington',  10,  '켄싱턴 호텔 제주',  '000',  '0000',  '0000',  '635',  '35', '제주특별자치도 서귀포시 중문관광로72번길 60', '색달동 켄싱턴 호텔 제주', '켄싱턴 제주_HI513292293.jpg',  '호텔설명',  '135', default, '호텔', 5);


-- 썬라이즈 호텔 성산점
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'sunrise', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '썬라이즈', '썬라씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'sunrise', 10, '썬라이즈 호텔 성산점', '000', '0000', '0000', '636', '43', '제주특별자치도 서귀포시 성산읍 성산등용로17번길 35', '썬라이즈 호텔 성산점', '썬라이즈 성산_HI557646981.jpg',  '호텔설명',  '88', default, '호텔', 3);





----------- >>>>>>>>>>>>> 경기도 <<<<<<<<<<<<<<<< --------------------------

-- 라마다 용인 호텔
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ramada',  2,  '라마다 용인 호텔',  '000',  '0000',  '0000',  '170',  '23', '경기도 용인시 처인구 포곡읍 마성로 420', '전대리 라마다호텔', '라마다 용인_HI543547033.jpg',  '호텔설명',  '89', default, '호텔', 4);


-- 엠블호텔 고양
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'amble', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '앰블', '앰블씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'amble',  2,  '엠블호텔 고양',  '000',  '0000',  '0000',  '103',  '94', '경기도 고양시 일산동구 태극로 20', '장항동 엠블호텔고양', '엠블호텔 고양_HI170589655.jpg',  '호텔설명',  '97', default, '호텔', 5);


-- 코트야드 바이 메리어트 서울 판교
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'marriott',  2,  '코트야드 바이 메리어트 서울 판교',  '000',  '0000',  '0000',  '135',  '24', '경기도 성남시 분당구 판교역로192번길 12', '삼평동 판교미래에셋센터', '메리어트 판교_HI521822406.jpg',  '호텔설명',  '77', default, '호텔', 4;


-- 밀리토피아 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'militopia', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '밀리토피아', '밀리씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'militopia',  2,  '밀리토피아 호텔',  '000',  '0000',  '0000',  '136',  '46', '경기도 성남시 수정구 위례대로 83', '주소2', '밀리토피아 호텔_HI510659706.jpg',  '호텔설명',  '67', default, '호텔', 4);


-- 대명 리조트 양평
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'daemyong',  2,  '대명 리조트 양평',  '000',  '0000',  '0000',  '125',  '66', '경기도 양평군 개군면 신내길7번길 55', '공세리 대명양평콘도미니엄', '대명 양평_HI506328396.jpg',  '호텔설명',  '78', default, '리조트', 3);


-- 블룸비스타
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'bloom', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '블룸', '블룸씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'bloom',  2,  '블룸비스타',  '000',  '0000',  '0000',  '125',  '75', '경기도 양평군 강하면 강남로 316', '전수리 블룸비스타', '블룸비스타_HI522650009.jpg',  '호텔설명',  '57', default, '호텔', 4);


-- 라비돌 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'rabidol', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '라비돌', '라비씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'rabidol',  2,  '라비돌 리조트',  '000',  '0000',  '0000',  '185',  '16', '경기도 화성시 정남면 세자로 286', '보통리 라비돌 리조트', '라비돌_HI563161258.jpg',  '호텔설명',  '88', default, '리조트', 2);


-- 엠스테이 호텔 기흥
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'amstay', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '엠스테이', '엠스씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'amstay', 2,  '엠스테이 호텔 기흥',  '000',  '0000',  '0000',  '171',  '08', '경기도 용인시 기흥구 서천로117번길 7', '서천동 M-STAY호텔기흥', '엠스테이_HI328483024.jpg',  '호텔설명',  '75', default, '호텔', 4);


-- 레이크힐스 안성 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'lakehills', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '레이크힐스', '레이씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'lakehills',  2,  '레이크힐스 안성 리조트',  '000',  '0000',  '0000',  '175',  '01', '경기도 안성시 양성면 양성로 349-61', '산정리 레이크힐스 안성 리조트', '레이크힐스 안성_HI293054590.jpg',  '리조트',  '67', default, '리조트', 1);


-- 수원 호텔 캐슬
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'castlesu', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '캐슬', '캐슬씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'castlesu',  2,  '수원 호텔 캐슬',  '000',  '0000',  '0000',  '173',  '84', '경기도 이천시 마장면 중부대로609번길 203', '목리 수원 호텔 캐슬', '캐슬 수원_HI368965484.jpg',  '호텔설명',  '87', default, '호텔', 2);








--------->>>>>>>>>>>>>>>>>> 서울 <<<<<<<<<<<<<<-----------------------------
-- 글래드 여의도
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'glad', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '글래드', '글래드', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'glad_yeouido',  1,  '글래드 여의도',  '02',  '6222',  '5000',  '072',  '36', '서울특별시 영등포구 의사당대로 16', '(여의도동, 서여의도비즈니스호텔)', '글래드_여의도_HI569532341.jpg',  '호텔설명',  '319', default, '호텔', 4);


-- 글래드 강남 코엑스 센터
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'glad_coex', 1,  '글래드 강남 코엑스 센터',  '000',  '0000',  '0000',  '061',  '74', '서울시 강남구 테헤란로 610', '(대치동, 호텔글래드강남코엑스센터)', '글래드_코엑스_HI503595952.jpg',  '호텔설명',  '282', default, '호텔', 3);


-- 그랜드 하얏트 서울
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hyatt',  1,  '그랜드 하얏트 서울',  '000',  '0000',  '0000',  '043',  '615', '서울특별시 용산구 소월로 322', '(한남동, 하얏트호텔)', '그랜드_하얏트_서울_HI545087425.jpg',  '호텔설명',  '120', default, '호텔', 5);


-- 신라스테이 광화문
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'shinlastay', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '신라스테이', '신라씨', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'shinla',  1,  '신라스테이 광화문',  '000',  '0000',  '0000',  '031',  '339', '서울특별시 종로구 삼봉로 71', '(수송동, G타워)', '신라스테이_광화문_HI516302652.jpg',  '호텔설명',  '120', default, '호텔', 5);


-- 신라스테이 마포
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'shinla',  1,  '신라스테이 광화문',  '000',  '0000',  '0000',  '041',  '383', '서울특별시 마포구 마포대로 83', '(도화동)', '신라스테이_마포_HI530105012.jpg',  '호텔설명',  '80', default, '호텔', 3);


-- L7 강남 바이 롯데
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'lotte',  1,  'L7 강남 바이 롯데',  '000',  '0000',  '0000',  '061',  '60', '서울특별시 강남구 테헤란로 415', '(삼성동, (주)호텔롯데L7강남)', 'L7_강남_바이_롯데_HI545542792.jpg',  '호텔설명',  '330', default, '호텔', 4);


-- 라마다 앙코르 서울 마곡
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ramada',  1,  '라마다 앙코르 서울 마곡',  '000',  '0000',  '0000',  '077',  '88', '서울특별시 강서구 마곡중앙로 161-11', '(마곡동, 힐스테이트에코마곡나루역라마다앙코르서울)', '라마다_앙코르_서울_마곡_HI368647858.jpg',  '호텔설명',  '120', default, '호텔', 3);


-- 호텔 아트리움 종로
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'artrium', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '아트리움', '아트리움', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'artrium',  1,  '호텔 아트리움 종로',  '000',  '0000',  '0000',  '031',  '30', '서울특별시 종로구 창경궁로 106', '(인의동, 호텔아트리움)', '호텔_아트리움_종로_HI574678378.jpg',  '호텔설명',  '120', default, '호텔', 3);


-- 임피리얼 팰리스 부티크 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'imperial', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '임피리얼', '임피리얼', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'imperial',  1,  '임피리얼 팰리스 부티크 호텔',  '000',  '0000',  '0000',  '043',  '49', '서울특별시 용산구 이태원로 221', '(한남동, 임피리얼팰리스부티크호텔)', '임피리얼_팰리스_호텔_HI564846372.jpg',  '호텔설명',  '132', default, '호텔', 3);


-- 프리마 호텔 서울
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'prima', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '프리마', '프리마', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'prima',  1,  '프리마 호텔 서울',  '000',  '0000',  '0000',  '060',  '71', '서울특별시 강남구 도산대로 536', '(청담동, 프리마호텔)', '프리마_호텔_서울HI573104031.jpg',  '호텔설명',  '120', default, '호텔', 3);

select *
from acc_tbl;

-------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>강원<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- 스카이베이 경포호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'skybay', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '스카이베이', '스카이베이', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'skybay',  3,  '스카이베이 경포호텔',  '000',  '0000',  '0000',  '254',  '60', '강원도 강릉시 해안로 476', '(강문동, 스카이베이경포호텔)', '스카이베이_경포호텔_HI508889735.jpg',  '호텔설명',  '200', default, '호텔', 4);


-- 켄싱턴 호텔 평창
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kensington',  3,  '켄싱턴 호텔 평창',  '000',  '0000',  '0000',  '253',  '22', '강원도 평창군 진부면 진고개로 231', '(간평리, 켄싱턴플로라호텔)', '켄싱턴_호텔_평창_HI573703925.jpg',  '호텔설명',  '305', default, '호텔', 5);


-- 휘닉스 평창 콘도미니엄
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'phoenix', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '휘닉스', '휘닉스', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'phoenix',  3,  '휘닉스 평창 콘도미니엄',  '000',  '0000',  '0000',  '253',  '07', '강원도 평창군 봉평면 태기로 174', '(면온리, (주)휘닉스평창)', '휘닉스_평창_콘도미니엄_HI569110762.jpg',  '호텔설명',  '200', default, '호텔', 4);


-- 정선 메이힐스 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'mayhills', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '메이힐스', '메이힐스', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'mayhills',  3,  '정선 메이힐스 리조트',  '000',  '0000',  '0000',  '261',  '55', '강원도 정선군 고한읍 물한리길 8', '(고한리, 메이힐리조트)', '정선_메이힐스_리조트_HI508881076.jpg',  '호텔설명',  '250', default, '리조트', 4);


-- 평창 라마다 호텔&스위트
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'ramada',  3,  '평창 라마다 호텔 스위트',  '000',  '0000',  '0000',  '253',  '42', '강원도 평창군 대관령면 오목길 107', '(횡계리)', '평창_라마다_호텔앤스위트_HI545984046.jpg',  '호텔설명',  '678', default, '호텔', 4);


-- 속초 마레몬스 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'maremons', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '마레몬스', '마레몬스', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'maremons',  3,  '속초 마레몬스 호텔',  '000',  '0000',  '0000',  '249',  '02', '강원도 속초시 동해대로 3705', '(대포동)', '속초_마레몬스_호텔_HI575283270.jpg',  '호텔설명',  '148', default, '호텔', 4);


-- 디그니티 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'dignity', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '디그니티', '디그니티', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'dignity',  3,  '디그니티 호텔',  '000',  '0000',  '0000',  '250',  '15', '강원도 양양군 양양읍 일출로 159-5', '(조산리, 디그니티호텔)', '디그니티_호텔_HI531065348.jpg',  '호텔설명',  '72', default, '호텔', 3);


-- 대명 비발디 파크
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'daemyong',  3,  '대명 비발디 파크',  '000',  '0000',  '0000',  '251',  '02', '강원도 홍천군 서면 한치골길 262', '(팔봉리, 대명비발디파크)', '대명_비발디_파크_HI567473973.jpg',  '호텔설명',  '500', default, '호텔', 4);


-- 하이원 그랜드 호텔 컨벤션타워
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'hione', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '하이원', '하이원', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hione',  3,  '하이원 그랜드 호텔 컨벤션타워',  '000',  '0000',  '0000',  '261',  '54', '강원도 정선군 사북읍 하이원길 265', '(사북리, 강원랜드)', '하이원_그랜드호텔_컨벤션타워_HI533287709.jpg',  '호텔설명',  '150', default, '호텔', 5);


-- 파인포레스트 정선 알파인리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'fineforest', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '파인포레스트', '파인포레스트', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'fineforest',  3,  '파인포레스트 정선 알파인리조트',  '000',  '0000',  '0000',  '261',  '00', '강원도 정선군 북평면 중봉길 23', '(숙암리, 포레스트)', '파인포레스트_정선_알파인리조트_HI573701769.jpg',  '호텔설명',  '127', default, '호텔', 4);






-------------- >>>>>>>>>>>>>>>>>>>> 전남 <<<<<<<<<<<<<<<<<<<<<
-- 더 호텔 수
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'the_sue', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '수', '수', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'the_sue',  9,  '더 호텔 수',  '000',  '0000',  '0000',  '597',  '67', '전라남도 여수시 돌산읍 엑스포대로 71', '(우두리)', '더_호텔_수_HI371248331.jpg',  '호텔설명',  '126', default, '호텔', 3);


-- 오션힐 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'oceanhill', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '오션힐', '오션힐', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'oceanhill',  9,  '오션힐 호텔',  '000',  '0000',  '0000',  '우편번호1',  '우편번호2', '전라남도 여수시 돌산읍 강남해안로 81', '(우두리)', '오션힐_호텔_HI545101073.jpg',  '호텔설명',  '88', default, '호텔', 1);


-- 한옥 호텔 영산재
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'youngsanjae', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '영산재', '영산재', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'youngsanjae',  9,  '한옥 호텔 영산재',  '000',  '0000',  '0000',  '584',  '47', '전라남도 영암군 삼호읍 나불외도로 126-17', '(나불리)', '한옥_호텔_영산재_HI379885628.jpg',  '호텔설명',  '80', default, '호텔', 3);


-- 샹그리아비치호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'shangria', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '샹그리아', '샹그리아', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'shangria',  9,  '샹그리아비치호텔',  '000',  '0000',  '0000',  '587',  '47', '전라남도 목포시 평화로 79', '(상동, 샹그리아비치호텔)', '샹그리아비치호텔_HI531066018.jpg',  '호텔설명',  '80', default, '호텔', 3);


-- 빛가람 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'garam', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '빛가람', '빛가람', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'garam',  9,  '빛가람 호텔',  '000',  '0000',  '0000',  '582',  '61', '전라남도 나주시 빛가람로 36', '(송월동)', '빛가람_호텔_HI521039521.jpg',  '호텔설명',  '100', default, '호텔', 3);


-- 순천만S호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'suncheonman', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '순천만S', '순천만', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'suncheonman',  9,  '순천만S호텔',  '000',  '0000',  '0000',  '580',  '02', '전라남도 순천시 팔마2길 61', '(연향동, 순천만에스호텔)', '순천만S호텔_HI510665345.jpg',  '호텔설명',  '51', default, '호텔', 2);


-- 오동재 한옥 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'odongjae', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '오동재', '오동재', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'odongjae',  9,  '오동재 한옥 호텔',  '000',  '0000',  '0000',  '우편번호1',  '우편번호2', '전라남도 여수시 박람회길 99', '(덕충동, 한옥호텔오동재)', '오동재_한옥_호텔_HI546268819.jpg',  '호텔설명',  '50', default, '호텔', 3);


-- 여수 르그랑블루 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'legrancblue', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '르그랑블루', '르그랑블루', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'legrancblue',  9,  '여수 르그랑블루 리조트',  '000',  '0000',  '0000',  '597',  '71', '전라남도 여수시 돌산읍 무술목길 34', '(평사리)', '여수_르그랑블루_리조트_HI513291974.jpg',  '호텔설명',  '18', default, '리조트', 2);


-- 샹보르 관광호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'shangbor', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '샹보르', '샹보르', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'shangbor',  9,  '샹보르 관광호텔',  '000',  '0000',  '0000',  '597',  '43', '전라남도 여수시 공화남2길 20', '(공화동)', '샹보르_관광호텔_HI298024621.jpg',  '호텔설명',  '237', default, '호텔', 1);







----------- >>>>>>>>>>>>>> 충청북도 <<<<<<<<<<<<<<<< --------------------------

-- 대명 리조트 단양
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'daemyong',  4,  '대명 리조트 단양',  '000',  '0000',  '0000',  '270',  '12', '충청북도 단양군 단양읍 삼봉로 187-17', '상진리 대명 리조트 단양', '대명리조트 단양_HI292984275.jpg',  '호텔설명',  '562', default, '리조트', 5);


-- 호텔 락희 청주
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'lacky', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '락희', '락희야', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'lacky',  4,  '호텔 락희 청주',  '000',  '0000',  '0000',  '284',  '25', '충청북도 청주시 흥덕구 대농로 47-2', '복대동 호텔 락희 청주', '호텔 락희 청주_HI366717969.jpg',  '호텔설명',  '590', default, '호텔', 4);


-- 호텔 뮤제오
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'mujeo', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '뮤제오', '뮤직박스', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'mujeo',  4,  '호텔 뮤제오',  '000',  '0000',  '0000',  '283',  '77', '충청북도 청주시 흥덕구 가로수로1164번길 41-20', '강서동 호텔 뮤제오', '호텔 뮤제오_HI372183063.jpg',  '호텔설명',  '468', default, '호텔', 3);


-- 켄싱턴 리조트 충주
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'kensington',  4,  '켄싱턴 리조트 충주',  '000',  '0000',  '0000',  '273',  '02', '충청북도 충주시 앙성면 산전장수1길 103', '돈산리 켄싱턴 리조트 충주', '켄싱턴 리조트 충주_HI570129113.jpg',  '호텔설명',  '411', default, '리조트', 1);


-- 제천 청풍 리조트
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'chung', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '청풍', '청풍이', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'chung',  4,  '제천 청풍 리조트',  '000',  '0000',  '0000',  '272',  '15', '충청북도 제천시 청풍면 청풍호로 1798 ', '교리 제천 청풍 리조트', '제천 청풍 리조트_HI330185838.jpg',  '호텔설명',  '333', default, '리조트', 2);


-- 단양 관광호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'danyang', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '단양관광', '단양관광장', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'danyang',  4,  '단양 관광호텔',  '000',  '0000',  '0000',  '270',  '13', '충청북도 단양군 단양읍 삼봉로 31', '상진리 단양관광호텔', '단양관광호텔_HI570550576.jpg',  '호텔설명',  '136', default, '호텔', 1);


-- 그랜드 플라자 청주 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'grand', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '그랜드 플라자', '그랜드', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'grand',  4,  '그랜드 플라자 청주 호텔',  '000',  '0000',  '0000',  '283',  '20', '충청북도 청주시 청원구 충청대로 114', '율량동 그랜드 플라자 청주 호텔', '그랜드 플라자 청주 호텔_HI363917556.jpg',  '호텔설명',  '725', default, '호텔', 3);


-- 베니키아 청주나무 호텔
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'bekinia',  4,  '베니키아 청주나무 호텔',  '000',  '0000',  '0000',  '283',  '11', '충청북도 청주시 상당구 명암로293번길 45', '명암동 베니키아 청주나무 호텔', '베니키아 청주나무 호텔_HI218132047.jpg',  '호텔설명',  '384', default, '호텔', 2);





----------- >>>>>>>>>>>>>> 충청남도 <<<<<<<<<<<<<<<< --------------------------

-- 롯데 리조트 부여
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'lotte',  5,  '롯데 리조트 부여',  '000',  '0000',  '0000',  '319',  '84', '충청남도 서산시 동헌로 94-1', '읍내동 롯데 리조트 부여', '롯데 리조트 부여_HI250109423.jpg',  '호텔설명',  '420', default, '리조트', 5);


-- 신라스테이 천안 
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'shinla',  5,  '신라스테이 천안',  '000',  '0000',  '0000',  '311',  '10', '충청남도 천안시 서북구 동서대로 177', '성정동 신라스테이 천안', '신라스테이 천안_HI323177515.jpg',  '호텔설명',  '615', default, '호텔', 5);


-- 오엔시티호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'oncity', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '오엔시티', '오웬', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'oncity',  5,  '오엔시티호텔',  '000',  '0000',  '0000',  '311',  '63', '충청남도 천안시 서북구 불당4로 105', '불당동 오엔시티호텔', '오엔시티호텔_HI510659587.jpg',  '호텔설명',  '410', default, '리조트', 3);


-- 글로리 콘도 도고
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'glory', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '글로리', '모닝글로리', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'glory',  5,  '글로리 콘도 도고',  '000',  '0000',  '0000',  '315',  '47', '충청남도 아산시 도고면 도고온천로 124-23', '기곡리, 도고글로리 글로리 콘도 도고', '글로리 콘도 도고_HI330159243.jpg',  '호텔설명',  '330', default, '리조트', 2);


-- 머드린 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'mudrin', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '머드린', '머드림', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'mudrin',  5,  '머드린 호텔',  '000',  '0000',  '0000',  '334',  '89', '충청남도 보령시 해수욕장8길 28', '신흑동 머드린 호텔', '머드린 호텔_HI508989069.jpg',  '호텔설명',  '710', default, '호텔', 4);


-- 티 포인트 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'Tpoint', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '티포인트', '포인트', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'Tpoint',  5,  '티 포인트 호텔',  '000',  '0000',  '0000',  '311',  '10', '충청남도 천안시 서북구 성정공원5로 42', '성정동 티 포인트 호텔', '티 포인트 호텔_HI400844883.jpg',  '호텔설명',  '296', default, '호텔', 3);


-- 온양 관광호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'onyang', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '온양관광', '온양이', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'onyang',  5,  '온양관광호텔',  '000',  '0000',  '0000',  '315',  '07', '충청남도 아산시 온천대로 1459', '온천동 온양관광호텔', '온양관광호텔_HI505542151.jpg',  '호텔설명',  '139', default, '호텔', 4);


-- 대명리조트 천안
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'daemyong',  5,  '대명리조트 천안',  '000',  '0000',  '0000',  '312',  '46', '충청남도 천안시 동남구 성남면 종합휴양지로 200', '용원리 대명리조트 천안', '대명리조트 천안_HI549549483.jpg',  '호텔설명',  '555', default, '호텔', 4);


-- 스파뷰 호텔
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'spaview', '5830e10608611059ceb92d2ef4d80c790e11a185c84f6284503de72baad765b5', '000', '00', '00000', '스파뷰', '스파스파', '1EysnNW20qS2dPy2JpKDIw==', '000', '0000', '0000', default);

insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'spaview',  5,  '스파뷰 호텔',  '000',  '0000',  '0000',  '324',  '06', '충청남도 예산군 덕산면 온천단지2로 77', '신평리 스파뷰 호텔', '스파뷰 호텔_HI510660169.jpg',  '호텔설명',  '120', default, '호텔', 1);


-- 한화 리조트 대천 파로스
insert into acc_tbl(acc_idx, cp_id, state, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_post1, acc_post2, acc_addr1, acc_addr2, acc_img, acc_text, acc_Rcnt, acc_status, acc_type, acc_grade)
values(seq_acc_tbl.nextval, 'hanhwa',  5,  '한화 리조트 대천 파로스',  '000',  '0000',  '0000',  '334',  '87', '충청남도 보령시 해수욕장3길 11-10', '신흑동 한화리조트 대천 파로스', '한화리조트 대천 파로스_HI510513053.jpg',  '호텔설명',  '657', default, '리조트', 5);

commit;

select count(*)
from acc_tbl;
-- 81

-- 2019.07.22 기업회원 1명 insert(김명진)
insert into company_mbr(idx, cp_id, cp_pwd, cp_num1, cp_num2, cp_num3, cp_name, ceoname, cp_email, cp_tel1, cp_tel2, cp_tel3, status)
values(seq_company_mbr.nextval, 'pikacu', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '000', '00', '00000', '피카츄', '지우', 'C/P74ewdLIh2ZJh1XD/vexaP+UsG9zKVXye7TBpMsQ8=', '000', '0000', '0000', default);

commit;
select acc_idx, acc_name, acc_tel1, acc_tel2, acc_tel3, acc_addr1,acc_img
		from acc_tbl
		order by acc_idx asc;
select *
from acc_tbl;
