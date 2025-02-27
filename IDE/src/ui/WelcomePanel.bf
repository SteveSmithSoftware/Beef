using Beefy.gfx; using Beefy.theme;
using Beefy.theme.dark;
using System;
using Beefy.widgets;

namespace IDE.ui
{
	class WelcomePanel : Panel
	{
		class SampleButton : Widget
		{
			public Image mImage;
			public String mLabel ~ delete _;
			public Font mFont;
			public String mPath ~ delete _;

			public override void Draw(Graphics g)
			{
				using (g.PushColor(mMouseOver ? ThemeColors.Panel.WorkspaceProperties002.Color : ThemeColors.Panel.WelcomePanel004.Color))
					using (g.PushScale(DarkTheme.sScale, DarkTheme.sScale))
						g.Draw(mImage);

				g.SetFont(mFont);
				g.DrawString(mLabel, 0, GS!(240), .Centered, mWidth);
			}

			public override void MouseEnter()
			{
				base.MouseEnter();
				gApp.SetCursor(.Hand);
			}

			public override void MouseLeave()
			{
				base.MouseLeave();
				gApp.SetCursor(.Pointer);
			}

			public override void MouseClicked(float x, float y, float origX, float origY, int32 btn)
			{
				base.MouseClicked(x, y, origX, origY, btn);

				gApp.[Friend]mDeferredOpen = .Workspace;
				String.NewOrSet!(gApp.[Friend]mDeferredOpenFileName, mPath);
			}
		}

		Font mLargeFont ~ delete _;
		Font mMedFont ~ delete _;
		Image mSampleImg0 ~ delete _;
		Image mSampleImg1 ~ delete _;
		SampleButton mSampleBtn0;
		SampleButton mSampleBtn1;

		public override bool WantsSerialization
		{
			get
			{
				return false;
			}
		}

		public float YOfs
		{
			get
			{
				return Math.Max(0, (mHeight - GS!(520)) * 0.35f);
			}
		}

		public this()
		{
			mSampleImg0 = Image.LoadFromFile(scope String()..AppendF(@"{}\images\welcome_sample0.png", gApp.mInstallDir));
			mSampleImg1 = Image.LoadFromFile(scope String()..AppendF(@"{}\images\welcome_sample1.png", gApp.mInstallDir));

			mSampleBtn0 = new .();
			mSampleBtn0.mPath = new String()..AppendF(@"{}\..\Samples\SpaceGame\BeefSpace.toml", gApp.mInstallDir);
			mSampleBtn0.mLabel = new String("Space Game");
			mSampleBtn0.mImage = mSampleImg0;
			AddWidget(mSampleBtn0);

			mSampleBtn1 = new .();
			mSampleBtn1.mPath = new String()..AppendF(@"{}\..\Samples\HelloWorld\BeefSpace.toml", gApp.mInstallDir);
			mSampleBtn1.mLabel = new String("Hello World");
			mSampleBtn1.mImage = mSampleImg1;
			AddWidget(mSampleBtn1);

			mClipGfx = true;
		}

		public override void RehupScale(float oldScale, float newScale)
		{
			base.RehupScale(oldScale, newScale);

			DeleteAndNullify!(mLargeFont);
			DeleteAndNullify!(mMedFont);
		}

		public override void DrawAll(Graphics g)
		{
			if (mLargeFont == null)
				mLargeFont = new Font()..Load("Segoe UI Bold", 60.0f * DarkTheme.sScale); //8.8
			if (mMedFont == null)
				mMedFont = new Font()..Load("Segoe UI Bold", 24.0f * DarkTheme.sScale); //8.8
			mSampleBtn0.mFont = mMedFont;
			mSampleBtn1.mFont = mMedFont;

			base.DrawAll(g);
		}

		public override void Draw(Graphics g)
		{
			using (g.PushColor(ThemeColors.Panel.WelcomePanel005.Color))
				g.FillRect(mWidth/2 - GS!(500), YOfs - GS!(24), GS!(500)*2, GS!(570));

			g.SetFont(mLargeFont);
			using (g.PushColor(ThemeColors.Panel.WelcomePanel006.Color))
				g.DrawString("Welcome to Beef", 0, GS!(0) + YOfs, .Centered, mWidth);

			g.SetFont(mMedFont);
					using (g.PushColor(ThemeColors.Theme.Text.Color))
			g.DrawString(scope String()..AppendF("Click on a sample projects below\n{}or{}\nCreate a project from the File menu", Font.EncodeColor(ThemeColors.Panel.WelcomePanel007.Color), Font.EncodePopColor()),
				GS!(32), GS!(95) + YOfs, .Centered, mWidth - GS!(64));
		}

		public override void Update()
		{
			base.Update();

			mSampleBtn0.Resize(mWidth / 2 - GS!(32 + 320), GS!(224) + YOfs, GS!(320), GS!(240));
			mSampleBtn1.Resize(mWidth / 2 + GS!(32), GS!(224) + YOfs, GS!(320), GS!(240));
		}
	}
}
