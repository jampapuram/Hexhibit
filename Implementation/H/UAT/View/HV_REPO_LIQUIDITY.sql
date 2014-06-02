
  CREATE OR REPLACE  VIEW HV_REPO_LIQUIDITY (COMPANY, PORTFOLIO, PORTFOLIO_NAME, TRANS_DATE, PORTFOLIO_CATEGORY, PORTFOLIO_CATEGORY_NAME, RELATED_PARTY, RELATED_PARY_NAME, RELATED_PARTY_TYPE, SECTOR_CATEGORY, ASSET_GROUP, ASSET_GROUP_NAME, ASSET_CLASS, ASSET_NAME, SECURITY, SECURITY_NAME, MATURITY_DAYS, LIQUIDITY, IS_FIXED_INCOME) AS 
  select  holding.company, holding.portfolio, holding.portfolio_name, holding.trans_date, holding.portfolio_category, holding.portfolio_category_name,
        holding.issuer as related_party, holding.issuer_name as related_pary_name, holding.issuer_type as related_party_type, holding.sector_category,
        holding.asset_group, holding.asset_group_name, holding.asset_class, holding.asset_name, holding.security, holding.security_name, holding.maturity_days,
        holding.market_value_pcy as liquidity, holding.is_fixed_income
from    HREP_SECURITY_HOLDING_CURR holding
union all
select  deposit.company, deposit.portfolio, deposit.portfolio_name, deposit.trans_date, deposit.portfolio_category, deposit.portfolio_category_name,
        deposit.counterparty as related_party, deposit.counterparty_name as related_pary_name, deposit.cparty_group as related_pary_type, null as sector_category,
        deposit.asset_group, deposit.asset_group_name, deposit.asset_class, DEPOSIT.ASSET_CLASS_NAME, deposit.trans_id as security, deposit.trans_id as security_name,
        deposit.maturity_days, deposit.maturity_amt_pcy as liquidity, 'Y' as is_fixed_income
from    HREP_DEPOSIT_TRANSACTIONS_CURR deposit
where   deposit.is_matured = 'N'
union all
select  repo.company, repo.portfolio, repo.portfolio_name, repo.trans_date, repo.portfolio_category, repo.portfolio_category_name,
        repo.counterparty as related_party, repo.counterparty_name as related_pary_name, repo.cparty_group as related_pary_type, null as sector_category,
        repo.asset_group, repo.asset_group_name, repo.asset_class, repo.asset_name, repo.trans_id as security, repo.trans_id as security_name, repo.maturity_days,
        repo.maturity_amt_pcy as liquidity, 'Y' as is_fixed_income
from    HREP_REPO_TXN_CURR repo
where   repo.is_matured = 'N';
 
