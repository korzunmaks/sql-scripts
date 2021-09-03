USE [RIASSE]
GO

/****** Object:  View [dbo].[���_��������_������������������]    Script Date: 11.02.2019 13:45:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[���_��������_������������������] as 
select j.date_time_iddoc date_time_iddoc
,j.iddoc iddoc
,j.sp6452 IDD
,j.docno ��������
,dbo.getDateTimeFromJourn(j.date_time_iddoc) �������
,j.closed closed
,j.sp1005 �����ID
,����.sp6368 �����IDD
,j.sp1006 �����ID
,����.sp6356 �����IDD
,���.sp3852 �����������
,j.sp1151 ��������
,j.sp2653 �������
,���.sp1008 ���������
,j.ismark ismark
--���������� ���� ���-�������������� ��� �������� ������� ��� ������������� ������ � ������������
,LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', ����.sp6368+���_�����_�����.SP6352),1), 18, 32))) AS ���������IDD
,LOWER(convert(varchar(32),substring(CONVERT(varchar(max), HashBytes('MD5', ����.sp6368+�������.SP6355),1), 18, 32))) AS ����������������IDD
--����� ����������� ��� ��������� ���������� view-������������� MsSQL
, ���.sp9111 as �����������������������
, ���.sp9110 as ��������������������
, ���.sp10345 as ���������10
, ���.sp10344 as ���������18
, ���.sp10337 as �����������
, ���.sp10343 as �����������0
, ���.sp10342 as �����������10
, ���.sp10341 as �����������18
, ���.sp3489 ������ID
, ���_�����_������.sp6339 ������IDD
, ���.sp8777 as ������������
, ���.sp9112 as �������
, ���.sp3490 as ����_�����
, ���.sp8776 as �����������
, ���.sp3495 ���ID
, ���_�����_���.sp6348 ���IDD
, ���.sp6308 ������ID
, ���_�����_������.sp6351 ������IDD
, ���.sp3491 as ����
, ���.sp9103 as ���������������
, ���.sp9102 as ���������������
, ���.sp5809 as ��������������
, ���.sp8575 as ����������
, ���.sp10338 as ���������������
, ���.sp3488 �����ID
, ���_�����_�����.sp6352 �����IDD
, ���.sp9109 as ��������������������
, ���.sp9108 as �����������������
, ���.sp10871 as ������������0
, ���.sp10872 as ������������10
, ���.sp10873 as ������������18
, ���.sp9106 as �����������������
, ���.sp9105 as ��������������
, ���.sp10874 as ���������������0
, ���.sp10875 as ���������������10
, ���.sp10876 as ���������������18
, ���.sp9107 as ��������������
, ���.sp9104 as �����������
, ���.sp10887 as ����������10
, ���.sp10888 as ����������18
, ���.sp10893 as ������������������
, ���.sp10894 as ���������������������
, ���.sp12527 as �������������18
, ���.sp12528 as �������������10
, ���.sp3504 as �����
, ���.sp3505 as ���
 from _1sjourn j with (nolock)
	left join sc13 ���� on (����.id = j.sp1005)
	left join sc838 ���� on (����.id = j.sp1006)
	inner join dh3487 ��� with (nolock) on (���.iddoc = j.iddoc)
	left join sc89  ���_�����_������ with (nolock) on (���_�����_������.id = ���.sp3489)
	left join sc3509  ���_�����_��� with (nolock) on (���_�����_���.id = ���.sp3495)
	left join sc46  ���_�����_������ with (nolock) on (���_�����_������.id = ���.sp6308)
	left join sc31  ���_�����_����� with (nolock) on (���_�����_�����.id = ���.sp3488)
	left join SC6115 ������� with (nolock) on (���_�����_�����.parentext = �������.ID)

where j.iddocdef = 3487
GO


