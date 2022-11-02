import * as React from 'react';
import { styled } from '@mui/material/styles'
import { AppBar, Card, Container, Box, CssBaseline, Button  } from '@mui/material';

// styling
const StyledCard = styled(Card)(({ theme }) => ({
  margin: theme.spacing(1),
  boxShadow: theme.shadows[3],
  color: theme.palette.error.main,
  minHeight: "250px",
  flexBasis: "250px"
  
}))

const Header = styled(AppBar)(({ theme }) => ({
  height: "50px",
  position: "sticky"
}))

// JSX
const Home = (): JSX.Element => {
  return(
    <>
      <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: "100vh" }}>
        <Header>
          SlowLoop Goods
        </Header>
        <CssBaseline/>
        <Box sx={{ display: 'flex', flexWrap: "wrap", minWidth: "100vw"}}>
          <StyledCard>
            グッズ名
            <Button>
              詳細
            </Button>
          </StyledCard>

          <StyledCard>
            グッズ
            <Button>
              詳細
            </Button>
          </StyledCard>

          <StyledCard>
            グッズ
            <Button>
              詳細
            </Button>
          </StyledCard>
        </Box>
      </Box>
    </>
  )
}

export default Home;
