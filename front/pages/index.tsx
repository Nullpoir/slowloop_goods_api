import * as React from 'react';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { AppBar, Card, Container, CssBaseline, Button  } from '@mui/material';

const theme = createTheme();

const Home = (): JSX.Element => {
  return(
    <div>
      <AppBar position="static">
        
        SlowLoop
      </AppBar>

      <Container>
        <Card>
          グッズ
          <Button>
            詳細
          </Button>
        </Card>

        <Card>
          グッズ
          <Button>
            詳細
          </Button>
        </Card>

        <Card>
          グッズ
          <Button>
            詳細
          </Button>
        </Card>
      </Container>
    </div>
  )
}

export default Home;
