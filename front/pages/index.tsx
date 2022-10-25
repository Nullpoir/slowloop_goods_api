import Head from 'next/head'
import Image from 'next/image'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import Typography from '@material-ui/core/Typography'
import Container from '@material-ui/core/Container'
import { makeStyles } from '@material-ui/core/styles'
import CssBaseline from '@material-ui/core/CssBaseline'

const useStyles = makeStyles((theme) => ({
  root: {
    display: 'flex',
    flexDirection: 'column',
    minHeight: '100vh',
  },
  main: {
    marginTop: theme.spacing(8),
    marginBottom: theme.spacing(2),
  },
  footer: {
    padding: theme.spacing(3, 2),
    marginTop: 'auto',
    backgroundColor: theme.palette.primary.main,
    color: 'white',
    textAlign: 'center',
  },
}))

export const Home = (): JSX.Element => {
  const classes = useStyles()
  return (
    <div className={classes.root}>
      <CssBaseline />
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <header>
        <AppBar position="relative">
          <Toolbar>
            <Typography variant="h6" color="inherit" noWrap>
              {"Material-UI"}
            </Typography>
          </Toolbar>
        </AppBar>
      </header>

      <main className={classes.root}>
        <Container component="main" className={classes.main} maxWidth="md">
          <h1 className="title">
            Welcome to <a href="https://nextjs.org">Next.js!</a>
          </h1>

          <p className="description">
            Get started by editing <code>pages/index.tsx</code>
          </p>

          <button
            onClick={() => {
              window.alert('With typescript and Jest')
            }}
          >
            Test Button
          </button>

          <div className="grid">
            <a href="https://nextjs.org/docs" className="card">
              <h3>Documentation &rarr;</h3>
              <p>Find in-depth information about Next.js features and API.</p>
            </a>

            <a href="https://nextjs.org/learn" className="card">
              <h3>Learn &rarr;</h3>
              <p>Learn about Next.js in an interactive course with quizzes!</p>
            </a>

            <a
              href="https://github.com/vercel/next.js/tree/master/examples"
              className="card"
            >
              <h3>Examples &rarr;</h3>
              <p>Discover and deploy boilerplate example Next.js projects.</p>
            </a>

            <a
              href="https://vercel.com/new?utm_source=create-next-app&utm_medium=default-template&utm_campaign=create-next-app"
              className="card"
            >
              <h3>Deploy &rarr;</h3>
              <p>Instantly deploy your Next.js site to a public URL with Vercel.</p>
            </a>
          </div>
        </Container>
      </main>

      <footer className={classes.footer}>
        <a
          href="https://vercel.com?utm_source=create-next-app&utm_medium=default-template&utm_campaign=create-next-app"
          target="_blank"
          rel="noopener noreferrer"
        >
          Powered by{' '}
          <Image src="/vercel.svg" alt="Vercel Logo" height={'32'} width={'64'} />
        </a>
      </footer>

      <style jsx>{`
        // 変更なしのため割愛
        ・・・
      `}</style>
    </div>
  )
}

export default Home
