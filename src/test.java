import java.time.Year;

class test
{
    public static void main(String[] args)
    {
        String v = "nghn";
        //BigInteger a = BigInteger.valueOf(Long.parseLong(v));
        System.out.println(Year.now().getValue());
        System.out.println(v.isEmpty());
        System.out.println("965852639".matches("^[0-9]*$"));
        System.out.println("@fgd.com".matches("^[A-Za-z0-9+_.-]+@(.+)$"));
        String a = "dwasd" + 5;
        System.out.println(a);


    }
}
