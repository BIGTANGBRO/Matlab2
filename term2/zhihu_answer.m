clc
clear
%this script is to generate answers about how rubbish mechanical and aeronautical
%engineering is. The format is typically �ƺ�style.
mkdir zhihu_answers
cd zhihu_answers

n=input('How many �ƺ� answers would you like to make?');

for i=1:n
    pay_after=round(unifrnd(10,39,1,1));
    pay_before=round(unifrnd(2,8,1,1));
    num=round(10*rand(1));
    if  num > 7
        school=('985');
    elseif num >3 || num <7
        school=('211');
    else
        school=('˫��');
    end
    if isprime(round(10*rand(1)))==1
        job=('������');
        com=('����');
    else
        job=('IT');
        com=('����');
    end
    if mod(num,2)==0
        city=('���߳���');
    else
        city=('һ�߳���');
    
    end
    fname=['k',num2str(i),'-.txt'];
    fid=fopen(fname,'w');
    fprintf(fid,'����֮ǰ��%s��У��е�������ҹ���ĳ%s����%dK,����������ת��%s��ҵ���־�%s��������%dK, Ȱ��ѧ�������������',school,com,pay_before,job,city,pay_after);
    fclose(fid);
end



    