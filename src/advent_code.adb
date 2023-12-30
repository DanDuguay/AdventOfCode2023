with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure Advent_Code is
   File      : File_Type;
   File_Name : constant String := "AC1_input.txt";
   Line      : Unbounded_String;
   Count     : Integer := 0;

   function extract_and_add
     (Line      : Unbounded_String) return Integer is
      First_Int : Character := ' ';
      Last_Int  : Character := ' ';
      Answer    : String := ("AB");
   begin
      for I in 1 .. Length (Line) loop
         Put_Line ("I: " & Integer'Image (I));
         if Is_Digit (Element (Line, I)) and First_Int = ' ' then
            First_Int := Element (Line, I);
            Last_Int := Element (Line, I);
            Put_Line ("First_Int: " & First_Int);
            Put_Line ("Last_Int: " & Last_Int);
         elsif Is_Digit (Element (Line, I)) then
            Last_Int := Element (Line, I);
            Put_Line ("Last_Int: " & Last_Int);
         end if;
      end loop;

      Answer := First_Int & Last_Int;
      Put_Line ("Answer: " & Answer);
      return Integer'Value (Answer);
   end extract_and_add;

begin
   Open (File, In_File, File_Name);
   while not End_Of_File (File) loop
      Line := To_Unbounded_String (Get_Line (File));
      Count := Count + extract_and_add (Line);
   end loop;
   Put_Line (Integer'Image (Count));
   Close (File);
end Advent_Code;
