/*
Run this script on SQL Server 2019 or later. There may be flaws if running on earlier versions of SQL Server.
this is a test
*/
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[countStudies]
(
	@studyId1 int,
	@studyId2 int,
	@studyId3 int,
	@studyId4 int,
	@studyId5 int,
	@studyId6 int,
	@studyId7 int,
	@studyId8 int
)
returns int
as
begin

declare @count as int;
set @count = 0;

if (@studyId1 > 0)
	set @count =  1;

if (@studyId2 > 0)
	set @count =  @count + 1;
if (@studyId3 > 0)
	set @count =  @count + 1;
if (@studyId4 > 0)
	set @count =  @count + 1;
if (@studyId5 > 0)
	set @count =  @count + 1;
if (@studyId6 > 0)
	set @count =  @count + 1;
if (@studyId7 > 0)
	set @count =  @count + 1;
if (@studyId8 > 0)
	set @count =  @count + 1;

return @count

end
GO
GRANT EXECUTE ON [dbo].[countStudies] TO [public]
GO
