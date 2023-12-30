with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Strings; use Ada.Strings;

procedure Advent_Code is
   File      : File_Type;
   File_Name : constant String := "AC1_input.txt";
   Line      : Unbounded_String;
   Count     : Integer := 0;

   function Find_And_Replace
     (Line      : Unbounded_String) return Unbounded_String is
      type Num_Words is (zero, one, two, three, four, five, six, seven, eight,
                         nine);
      My_Index    : Natural;
      String_Source : String := To_String (Line);
   begin
      for J in 1 .. 15 loop
         for I in Num_Words loop
            --  Put_Line ("String_Source: " & String_Source);
            --  Put_Line ("I: " & To_Lower (Num_Words'Image (I)));

            My_Index := Index (Source => String_Source,
                               Pattern => To_Lower (Num_Words'Image (I)));

            if My_Index > 0 then
               Overwrite
                 (Source => String_Source,
                  Position => My_Index,
                  New_Item => Integer'Image (Num_Words'Pos (I)),
                  Drop => Left);
               --  Put_Line (To_String (Line));
            end if;
         end loop;
      end loop;
      return To_Unbounded_String (String_Source);
   end Find_And_Replace;

   function Extract_And_Add
     (Line      : Unbounded_String) return Integer is
      First_Int : Character := ' ';
      Last_Int  : Character := ' ';
      Answer    : String := ("AB");
   begin
      for I in 1 .. Length (Line) loop
         --  Put_Line ("I: " & Integer'Image (I));
         if Is_Digit (Element (Line, I)) and First_Int = ' ' then
            First_Int := Element (Line, I);
            Last_Int := Element (Line, I);
            --  Put_Line ("First_Int: " & First_Int);
            --  Put_Line ("Last_Int: " & Last_Int);
         elsif Is_Digit (Element (Line, I)) then
            Last_Int := Element (Line, I);
            --  Put_Line ("Last_Int: " & Last_Int);
         end if;
      end loop;

      Answer := First_Int & Last_Int;
      Put_Line ("Answer: " & Answer);
      return Integer'Value (Answer);
   end Extract_And_Add;

begin
   Open (File, In_File, File_Name);
   while not End_Of_File (File) loop
      Line := To_Unbounded_String (Get_Line (File));
      Line := Find_And_Replace (Line);
      Count := Count + Extract_And_Add (Line);
      -- Put_Line (Integer'Image (Count));
   end loop;
   Put_Line (Integer'Image (Count));
   Close (File);
end Advent_Code;
