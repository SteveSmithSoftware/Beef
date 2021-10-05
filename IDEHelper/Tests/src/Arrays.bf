#pragma warning disable 168

using System;
namespace Tests
{
	class Arrays
	{
		public static float[,] GetArray() => new .[,] ( ( 0, 1, 2, 3), ( 10, 11, 12, 13 ), ( 20, 21, 22, 23 ) );

		struct StructA
		{
			public int16 mA = 11;
			public int16 mB = 22;
			public int16 mC = 33;
		}

		[Test]
		public static void TestPacking()
		{
			StructA[] arr = scope .[3](.(), );

			ref StructA sa = ref arr[0];
			Test.Assert(sa.mA == 11);
			Test.Assert(sa.mB == 22);
			Test.Assert(sa.mC == 33);

			var val = arr[(.)1];
			int[3] arr2 = .(1, 2, 3);
			var val2 = arr2[(.)1];

#if BF_64_BIT
			/*int a = (int)(void*)&sa - (int)Internal.UnsafeCastToPtr(arr);
			int b = typeof(System.Array).InstanceSize;

			Test.Assert((int)(void*)&sa - (int)Internal.UnsafeCastToPtr(arr) == sizeof(System.Array));*/
#endif
		}
	}
}
