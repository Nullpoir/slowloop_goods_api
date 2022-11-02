import * as React from 'react';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { AppBar, Card, Container, CssBaseline, Button  } from '@mui/material';

const Home = (): JSX.Element => {
  return(
    <div>
      <AppBar position="static">
        
        SlowLoop Goods
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
