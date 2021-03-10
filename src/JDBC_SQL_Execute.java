import java.sql.*;

class JDBC_SQL_Execute
{
    private Connection conn;

    public JDBC_SQL_Execute() throws SQLException
    {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/find_college_db", "Mayank", "apple");
    }

    int InsertValues(College clg) throws Exception
    {
        ViewAllColleges();
        for (College college : College_Main.clgs)
        {
            if (college.getName().equals(clg.getName())) return 1;
        }
        PreparedStatement stmt;
        stmt = conn.prepareStatement("insert into Colleges(CNAME,MIN_PERCENTAGE,FEES,LOCATION,CONTACT,EMAIL,WEBSITE) values(?,?,?,?,?,?,?)");
        stmt.setString(1, clg.getName());
        stmt.setFloat(2, clg.getPercentage());
        stmt.setInt(3, clg.getFees());
        stmt.setString(4, clg.getLocation());
        stmt.setString(5, clg.getContact());
        stmt.setString(6, clg.getEmail());
        stmt.setString(7, clg.getWebsite());
        stmt.executeUpdate();

        stmt = conn.prepareStatement("insert into LOGIN_COLLEGES(EMAIL,PASSWRD) values(?,?)");
        stmt.setString(1, clg.getEmail());
        stmt.setString(2, clg.getPassword());
        stmt.executeUpdate();
        return 0;
    }


    void InsertValues(Student student) throws Exception
    {

        PreparedStatement stmt;
        stmt = conn.prepareStatement("insert into students(FNAME , MNAME, LNAME ,DOB ,GENDER ,CONTACT,EMAIL,LOCATION ) values(?,?,?,?,?,?,?,?)");
        stmt.setString(1, student.getFname());
        stmt.setString(2, student.getMname());
        stmt.setString(3, student.getLname());
        stmt.setString(4, student.getDob());
        stmt.setString(5, student.getGender());
        stmt.setString(6, student.getContact());
        stmt.setString(7, student.getEmail());
        stmt.setString(8, student.getLocation());
        stmt.executeUpdate();

        stmt = conn.prepareStatement("insert into LOGIN_STUDENTS(EMAIL,PASSWRD) values(?,?)");
        stmt.setString(1, student.getEmail());
        stmt.setString(2, student.getPassword());
        stmt.executeUpdate();
    }

    void InsertValues(Marks marks) throws Exception
    {

        PreparedStatement stmt;
        stmt = conn.prepareStatement("INSERT INTO MARKS(ENGLISH,HINDI_KANNADA,MATHS,PHYSICS,CHEMISTRY,COMPUTER_BIOLOGY) VALUES(?,?,?,?,?,?);");
        stmt.setInt(1, marks.getEnglish());
        stmt.setInt(2, marks.getHindiKannada());
        stmt.setInt(3, marks.getMaths());
        stmt.setInt(4, marks.getPhysics());
        stmt.setInt(5, marks.getChemistry());
        stmt.setInt(6, marks.getComputerBiology());
        stmt.executeUpdate();
        CallStoredProcedure();
    }


    void ViewAllColleges() throws Exception
    {
        PreparedStatement stmt;
        stmt = conn.prepareStatement("select * from colleges");
        ResultSet rs = stmt.executeQuery();
        College_Main.clgs.clear();
        while (rs.next())
        {
            College college = new College();
            college.setCollege_id(rs.getInt("COLLEGE_ID"));
            college.setName(rs.getString("CNAME"));
            college.setPercentage(rs.getFloat("MIN_PERCENTAGE"));
            college.setFees(rs.getInt("FEES"));
            college.setLocation(rs.getString("LOCATION"));
            college.setContact(rs.getString("CONTACT"));
            college.setEmail(rs.getString("EMAIL"));
            college.setWebsite(rs.getString("WEBSITE"));
            College_Main.addClg(college);

        }
    }

    void DeleteCollege(String nameOrEmail) throws SQLException
    {
        PreparedStatement stmt;
        if (!nameOrEmail.contains("@")) stmt = conn.prepareStatement("delete from colleges where cname=?");
        else stmt = conn.prepareStatement("delete from colleges where EMAIL=?");
        stmt.setString(1, nameOrEmail);
        stmt.executeUpdate();
        College_Main.clgs.clear();
    }

    int CollegeLogin(String email, String password) throws SQLException
    {
        PreparedStatement stmt;
        stmt = conn.prepareStatement("select COLLEGE_ID from LOGIN_COLLEGES where EMAIL=? and PASSWRD=?");
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();
        int count = 0;
        while (rs.next())
        {
            count++;
        }
        if (count != 1)
        {
            return 1;
        }
        return 0;
    }

    void CollegeUpdate(float percentage, String email) throws SQLException
    {
        PreparedStatement stmt;
        stmt = conn.prepareStatement("update colleges set MIN_PERCENTAGE=? where EMAIL=?");
        stmt.setFloat(1, percentage);
        stmt.setString(2, email);
        stmt.executeUpdate();
    }

    void CollegeUpdate(int fees, String email) throws SQLException
    {
        PreparedStatement stmt;
        stmt = conn.prepareStatement("update colleges set FEES=? where EMAIL=?");
        stmt.setInt(1, fees);
        stmt.setString(2, email);
        stmt.executeUpdate();
    }

    void CollegeUpdate(String contact, String email) throws SQLException
    {
        PreparedStatement stmt;
        stmt = conn.prepareStatement("update colleges set CONTACT=? where EMAIL=?");
        stmt.setString(1, contact);
        stmt.setString(2, email);
        stmt.executeUpdate();
    }

    int StudentLogin(String email, String password) throws SQLException
    {
        PreparedStatement stmt;
        stmt = conn.prepareStatement("select STUDENT_ID from LOGIN_STUDENTS where EMAIL=? and PASSWRD=?");
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();
        int count = 0;
        while (rs.next())
        {
            count++;
        }
        if (count != 1)
        {
            return 1;
        }
        return 0;
    }

    void DeleteStudent(String idOrEmail) throws SQLException
    {
        PreparedStatement stmt;
        if (!idOrEmail.contains("@"))
        {
            int id = Integer.parseInt(idOrEmail);
            stmt = conn.prepareStatement("delete from students where STUDENT_ID=?");
            stmt.setInt(1, id);

        } else
        {
            stmt = conn.prepareStatement("delete from students where EMAIL=?");
            stmt.setString(1, idOrEmail);
        }
        stmt.executeUpdate();
        Student_Main.studs.clear();
    }

    private void StudentLoginUpdate(String newEmail, String email) throws SQLException
    {
        PreparedStatement stmt;
        stmt = conn.prepareStatement("update LOGIN_STUDENTS set EMAIL=? where EMAIL=?");
        stmt.setString(1, newEmail);
        stmt.setString(2, email);
        stmt.executeUpdate();
    }

    void StudentUpdate(String newValue, String email, int type) throws SQLException
    {
        PreparedStatement stmt = null;
        if (type == 1) stmt = conn.prepareStatement("update students set CONTACT=? where EMAIL=?");
        else if (type == 2)
        {
            stmt = conn.prepareStatement("update students set EMAIL=? where EMAIL=?");
            StudentLoginUpdate(newValue, email);
        } else if (type == 3) stmt = conn.prepareStatement("update students set LOCATION=? where EMAIL=?");

        assert stmt != null;
        stmt.setString(1, newValue);
        stmt.setString(2, email);
        stmt.executeUpdate();
    }

    private void CallStoredProcedure() throws SQLException
    {
        CallableStatement callableStatement;
        callableStatement = conn.prepareCall("{call GetAvgPer()}");
        callableStatement.executeUpdate();
    }

    void GetColleges(String email) throws Exception
    {
        CallStoredProcedure();
        ResultSet resultSet;
        PreparedStatement preparedStatement;
        College_Main.clgs.clear();
        preparedStatement = conn.prepareStatement("SELECT c.COLLEGE_ID, c.CNAME, c.MIN_PERCENTAGE, c.FEES, c.LOCATION, c.CONTACT, c.EMAIL, c.WEBSITE  FROM colleges c, students s, MARKS m WHERE s.STUDENT_ID = m.STUDENT_ID AND s.EMAIL =? AND m.PERCENTAGE >= c.MIN_PERCENTAGE GROUP BY c.COLLEGE_ID");
        preparedStatement.setString(1, email);
        resultSet = preparedStatement.executeQuery();

        while (resultSet.next())
        {
            College college = new College();
            college.setCollege_id(resultSet.getInt("COLLEGE_ID"));
            college.setName(resultSet.getString("CNAME"));
            college.setPercentage(resultSet.getFloat("MIN_PERCENTAGE"));
            college.setFees(resultSet.getInt("FEES"));
            college.setLocation(resultSet.getString("LOCATION"));
            college.setContact(resultSet.getString("CONTACT"));
            college.setEmail(resultSet.getString("EMAIL"));
            college.setWebsite(resultSet.getString("WEBSITE"));
            College_Main.addClg(college);

        }
    }

    String getStudentName(String email) throws SQLException
    {
        System.out.println(email);
        ResultSet resultSet;
        PreparedStatement preparedStatement;
        preparedStatement = conn.prepareStatement("SELECT Fname from students where email=?");
        preparedStatement.setString(1, email);
        resultSet = preparedStatement.executeQuery();
        resultSet.next();
        return resultSet.getString("FNAME");
    }

}
