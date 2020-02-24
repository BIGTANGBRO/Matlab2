clc
clear
%this script is to generate answers about how rubbish mechanical and aeronautical
%engineering is. The format is typically 逼乎style.
mkdir zhihu_answers
cd zhihu_answers

n=input('How many 逼乎 answers would you like to make?');

for i=1:n
    pay_after=round(unifrnd(10,39,1,1));
    pay_before=round(unifrnd(2,8,1,1));
    num=round(10*rand(1));
    if  num > 7
        school=('985');
    elseif num >3 || num <7
        school=('211');
    else
        school=('双非');
    end
    if isprime(round(10*rand(1)))==1
        job=('互联网');
        com=('国企');
    else
        job=('IT');
        com=('民企');
    end
    if mod(num,2)==0
        city=('二线城市');
    else
        city=('一线城市');
    
    end
    fname=['k',num2str(i),'-.txt'];
    fid=fopen(fname,'w');
    fprintf(fid,'本人之前在%s高校机械，出来找工作某%s开价%dK,工作几个月转行%s行业，现居%s，收入打包%dK, 劝人学机，天打雷劈。',school,com,pay_before,job,city,pay_after);
    fclose(fid);
end



    